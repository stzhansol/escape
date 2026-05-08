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
model = ''

try:
    with open(path) as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            try:
                obj = json.loads(line)
                if obj.get('type') == 'assistant':
                    msg = obj.get('message', {})
                    if not model:
                        model = msg.get('model', '')
                    u = msg.get('usage', {})
                    ti += u.get('input_tokens', 0)
                    to += u.get('output_tokens', 0)
                    cw += u.get('cache_creation_input_tokens', 0)
                    cr += u.get('cache_read_input_tokens', 0)
            except:
                pass
except:
    pass

print(f'{ti},{to},{cw},{cr},{model}')
" > /tmp/cc_session_cost.txt 2>/dev/null || echo "0,0,0,0," > /tmp/cc_session_cost.txt

RESULT=$(cat /tmp/cc_session_cost.txt)
INPUT_TOK=$(echo "$RESULT" | cut -d',' -f1)
OUTPUT_TOK=$(echo "$RESULT" | cut -d',' -f2)
CACHE_WRITE=$(echo "$RESULT" | cut -d',' -f3)
CACHE_READ=$(echo "$RESULT" | cut -d',' -f4)
MODEL=$(echo "$RESULT" | cut -d',' -f5)

LOG_ENTRY="$(date '+%Y-%m-%d %H:%M:%S') | ${SHORT_ID} | model:${MODEL} | in:${INPUT_TOK} out:${OUTPUT_TOK} cw:${CACHE_WRITE} cr:${CACHE_READ} | $(basename "$DEST")"
echo "$LOG_ENTRY" >> "$HISTORY_DIR/cost_log.txt"

echo "{\"systemMessage\": \"💾 히스토리 저장 | in:${INPUT_TOK} out:${OUTPUT_TOK} cw:${CACHE_WRITE} cr:${CACHE_READ}\"}"
