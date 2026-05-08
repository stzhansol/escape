#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
HISTORY_DIR="$PROJECT_DIR/_workspace/history"

mkdir -p "$HISTORY_DIR"

INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"' 2>/dev/null || echo "unknown")
TRANSCRIPT=$(echo "$INPUT" | jq -r '.transcript_path // ""' 2>/dev/null || echo "")

if [ -z "$TRANSCRIPT" ] || [ ! -f "$TRANSCRIPT" ]; then
  exit 0
fi

DATE=$(date "+%Y%m%d_%H%M%S")
SHORT_ID="${SESSION_ID:0:8}"
DEST="$HISTORY_DIR/${DATE}_${SHORT_ID}.jsonl"

cp "$TRANSCRIPT" "$DEST"

TRANSCRIPT_PATH="$DEST" python3 -c "
import json, os

path = os.environ['TRANSCRIPT_PATH']
ti = to = cw = cr = 0

try:
    with open(path) as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            try:
                obj = json.loads(line)
                if obj.get('type') == 'assistant':
                    u = obj.get('message', {}).get('usage', {})
                    ti += u.get('input_tokens', 0)
                    to += u.get('output_tokens', 0)
                    cw += u.get('cache_creation_input_tokens', 0)
                    cr += u.get('cache_read_input_tokens', 0)
            except:
                pass
except:
    pass

# Sonnet 4.6 API 환산 가격 (참고용, USD per 1M tokens)
cost = (ti * 3.0 + to * 15.0 + cw * 3.75 + cr * 0.30) / 1_000_000
print(f'{ti},{to},{cw},{cr},{cost:.4f}')
" > /tmp/cc_session_cost.txt 2>/dev/null || echo "0,0,0,0,0.0000" > /tmp/cc_session_cost.txt

RESULT=$(cat /tmp/cc_session_cost.txt)
INPUT_TOK=$(echo "$RESULT" | cut -d',' -f1)
OUTPUT_TOK=$(echo "$RESULT" | cut -d',' -f2)
CACHE_WRITE=$(echo "$RESULT" | cut -d',' -f3)
CACHE_READ=$(echo "$RESULT" | cut -d',' -f4)
COST=$(echo "$RESULT" | cut -d',' -f5)

LOG_ENTRY="$(date '+%Y-%m-%d %H:%M:%S') | ${SHORT_ID} | in:${INPUT_TOK} out:${OUTPUT_TOK} cw:${CACHE_WRITE} cr:${CACHE_READ} | \$${COST} | $(basename "$DEST")"
echo "$LOG_ENTRY" >> "$HISTORY_DIR/cost_log.txt"

echo "{\"systemMessage\": \"💾 히스토리 저장 | 이번 세션 토큰 비용(참고): \$${COST}\"}"
