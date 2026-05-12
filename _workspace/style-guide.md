# Style Guide — 「퇴근 승인 바랍니다」 비주얼 일관성 명세

> 모든 이미지 자산 생성은 이 문서의 5요소 프롬프트 + 컬러 팔레트 + 캐릭터 명세를 그대로 따른다.
> 변경이 필요하면 이 문서만 갱신하고 기존 자산은 재생성한다.

---

## 1. 화면/해상도 정책 (고정)

| 항목 | 값 |
|------|-----|
| Base resolution | 1920 × 1080 |
| Aspect | 16:9 (locked) |
| Godot stretch_mode | `canvas_items` |
| Godot stretch_aspect | `keep` (다른 종횡비는 letterbox) |
| Safe margin | 64 px (인터랙션 hitbox는 가장자리 64px 안쪽) |
| 터치 hitbox 최소 | 88 × 88 px (드래그 시작 노드는 120 × 120 px) |

asset-manifest의 모든 `position`, `size`, `hitbox`는 위 base 기준 픽셀로만 적는다.

---

## 2. 5요소 프롬프트 (모든 자산 동일 적용 — **LINELESS 기조**)

> 채택 기준은 `ceo_mascot_v2` (archive/ui_title_ceo_mascot_v2.png) 톤. 윤곽선 없이 면 + 톤 + 그림자만으로 형태 분리.

```
[STYLE]
LINELESS ILLUSTRATION, no outlines, no black line art,
vector flat illustration, cute corporate mascot style,
soft rounded shapes, smooth flat color fills,
shape separation only by soft tonal shading and gentle drop shadows,
minimal shading with slightly darker shades of base color,
friendly pastel palette

[LIGHTING]
soft diffused front light, no harsh shadows,
gentle soft drop shadow under main subject only,
even pastel tones, warm morning ambient

[TECH]
2D vector art, PNG with alpha channel,
smooth color fills, no edge strokes, no contour lines,
no gradient noise, no rough texture,
transparent background unless explicitly stated

[NEGATIVE]
NO outlines, NO black lines, NO line art,
no ink contours, no edge strokes, no border lines,
no text, no letters, no characters, no glyphs,
no typography, no readable symbols, no numbers,
no watermark, no logo letters,
no realistic photography, no 3d render,
no harsh shadows, no grainy texture,
no dark moody atmosphere, no anime sexual,
no extra limbs, no distorted proportions
```

**⚠ HEX 코드 주의** — 프롬프트 본문(SUBJECT/COMPOSITION)에 `#FFB7C9` 같은 hex 코드를 직접 적지 않는다. AI가 글리프(`FFB7C9` 글자)로 자산에 박는 사고가 있었음(`archive/ui_title_logo_text_bug.png` 참고). 색은 항상 자연어 이름으로:
- `#FFB7C9` → "soft baby pink"
- `#FFD8E0` → "light pink"
- `#E89BB0` → "slightly darker pink"
- `#FFF6EE` → "cream white"
- `#2E2E3A` → "dark ink charcoal" (텍스트 색 명시 시)
- `#F4C95D` → "honey yellow"
- `#3F3F4D` → "deep charcoal"

자산 호출 시에는 위 4블록을 그대로 포함하고 `[SUBJECT]` + `[COMPOSITION]` 두 블록만 자산별로 다르게 작성한다.

**Ludo MCP 호출 파라미터 기본값 (채택)**
- `art_style: "Vector Art"`
- `augment_prompt: false`
- `image_type`: `portrait`(캐릭터) / `fixed_background`(배경) / `ui_asset`(UI) / `item-icon`(아이콘) / `asset`(오브젝트)
- `n: 1`

---

## 3. 컬러 팔레트 (4색 + 보조 셰이드)

| 역할 | 이름 | HEX | 사용처 |
|------|------|-----|--------|
| **Primary** | Bunny Pink | `#FFB7C9` | 사장 캐릭터 본체, 회사 정체성, 강조 버튼 |
| **Background** | Cream White | `#FFF6EE` | 배경, 카드, 모달 패널 |
| **Ink** | Ink Charcoal | `#2E2E3A` | 텍스트, 라인 아트, 윤곽선, 본문 |
| **Accent** | Honey Yellow | `#F4C95D` | 포스트잇/단서/하이라이트/잠금 카드 힌트 |

**보조 셰이드 (필요 시 자동 파생)**
- Bunny Pink Dark `#E89BB0` — 사장 그림자/접힘
- Bunny Pink Light `#FFD8E0` — 사장 하이라이트, 핑크 톤 배경
- Cream Shadow `#EFE3D2` — Cream 위 카드 분리
- Ink Light `#5A5A6E` — 보조 텍스트, 비활성 라벨

프롬프트에 색 키워드 명시 시 위 이름을 그대로 쓰지 말고, 자연어로 풀어서 일관성 유도 (예: `soft baby pink #FFB7C9 dominant, cream white #FFF6EE background, dark ink charcoal lines`).

---

## 4. 캐릭터 명세 — 핑크 토끼 사장 (`npc_ceo`)

| 항목 | 값 |
|------|-----|
| 종 | 의인화 토끼 (anthropomorphic rabbit) |
| 베이스 컬러 | Bunny Pink `#FFB7C9` (몸 전체), 귀 안쪽 Bunny Pink Light `#FFD8E0` |
| 비율 | **머리 : 몸 = 1 : 0.7** (머리가 몸보다 큰 강한 SD/Q판 비율, 아기자기 강조) |
| 의상 | 검은 정장 + 흰 셔츠 + Honey Yellow `#F4C95D` 넥타이, 가슴에 작은 사원증 |
| 표정 셋 | `idle` (잔잔한 미소) / `disappointed` (눈썹 살짝 내림, 입꼬리 내림) / `proud` (눈 반짝, 양손 모음) |
| 포즈 | 차렷에 가까운 정중한 직립, 양손은 앞으로 모으거나 한쪽이 가슴에 |
| 라인 | **없음 (lineless illustration)** — 윤곽선 없이 면 분리. 형태 구분은 더 진한/연한 톤 차이로만 |
| 톤 분리 | 더 진한 분리가 필요한 부분은 베이스 컬러보다 살짝 진한 셰이드 사용 (예: 핑크 본체 vs 핑크 다크 `#E89BB0`, 정장 검정 vs 차콜 `#3F3F4D`) |
| 금지 | 무서운 표정, 날카로운 이빨, 어두운 그림자, 사악함, **검은 윤곽선** — 항상 친절·따뜻한 외관 |

**프롬프트 템플릿 (캐릭터 자산 공통, lineless)**
```
[SUBJECT]
a cute anthropomorphic pink rabbit CEO character, mascot style,
LINELESS ILLUSTRATION (no outlines, no black line art),
soft baby pink #FFB7C9 fur body, lighter pink #FFD8E0 inner ears,
shape separation only by slightly darker pink #E89BB0 tonal shading,
wearing a neat black corporate suit (charcoal #3F3F4D for fabric folds, no outline)
with white shirt and honey yellow #F4C95D necktie,
small employee badge on chest, gentle calm smile (idle expression),
standing posture with both hands folded politely in front,
{additional_pose_or_expression}
```

---

## 5. 자산 카테고리별 가이드 (**모든 카테고리 lineless 공통**)

> 윤곽선 없음. 형태 분리는 (a) 더 진한/연한 베이스 컬러 셰이드, (b) 부드러운 드롭 섀도우, (c) 톤 그라데이션 중 하나로만.

### 5.1 캐릭터 (npc / mascot)
- 항상 투명 배경 (`removeBackground` 후처리)
- 풀바디는 약 800×1200, 아바타는 256×256, 흉상은 480×600
- 표정 셋이 다른 자산은 같은 캐릭터 시트에서 파생 (`generateWithStyle` 또는 `editImage`)
- **윤곽선 없음** — 라인 대신 베이스 컬러 + 더 진한 셰이드(예: Bunny Pink `#FFB7C9` → `#E89BB0`)로 면 분리
- 채택 레퍼런스: `archive/ui_title_ceo_mascot_v2.png`

### 5.2 배경 (`*_bg`, `ui_*_bg`, 씬 배경)
- 인터랙션 오브젝트가 놓일 자리는 비워둔다 (책상 위 단서 자리는 빈 책상)
- 1920×1080 풀스크린 또는 모달용 1600×900
- LIGHTING은 같은 씬 내에서 통일 (예: 사무실 모든 자산은 상단 우측 부드러운 라이트)
- 배경 톤은 Cream White 베이스 + Bunny Pink Light/Honey Yellow 살짝 가미
- **윤곽선 없음** — 가구·벽 분리는 톤 차이로만
- 채택 레퍼런스: `assets/main_menu/ui_title_bg.png`

### 5.3 인터랙션 오브젝트 (`obj_*`, `item_*`)
- 투명 배경 (`removeBackground` 후처리)
- 같은 씬 내 LIGHTING 일치
- 두 상태가 있는 오브젝트는 `_state` 접미사 (예: `obj_drawer_closed`, `obj_drawer_open`)
- **윤곽선 없음** — 면+톤+얕은 드롭 섀도우로 입체감

### 5.4 UI (`ui_*`)
- 버튼·프레임은 둥근 모서리 (border-radius 16~24px 느낌)
- **윤곽선 없음** — 채움색 단일 면, 분리는 살짝 어두운 채움 (`#E89BB0`) 또는 옅은 드롭 섀도우
- 채움은 Bunny Pink/Cream/Honey Yellow 중 역할에 맞게
- 텍스트는 자산에 그리지 않고 Godot에서 Label로 오버레이 (한글 AI 생성 부정확 회피)

### 5.5 아이콘 (앱 아이콘, 인벤토리)
- 64~128px 정사각, 둥근 사각형 베이스
- 단순한 픽토그램, Honey Yellow 액센트
- **윤곽선 없음** — 픽토그램은 면+톤으로만 (선 아이콘 금지)

---

## 6. 일관성 체크리스트 (디자이너가 자산 생성 후 확인)

- [ ] **윤곽선이 없는가** (검은/짙은 라인이 보이면 재생성 — `archive/ui_title_ceo_mascot_v3.png`처럼 라인 들어온 케이스 회피)
- [ ] 형태 분리가 면+톤+드롭 섀도우로만 이루어졌는가
- [ ] 5요소 프롬프트 4블록(STYLE/LIGHTING/TECH/NEGATIVE)을 그대로 사용했는가
- [ ] 컬러 팔레트 4색 + 보조 셰이드 범위 안에 있는가
- [ ] 같은 씬 내 다른 자산과 LIGHTING이 같은가
- [ ] 텍스트가 자산에 박혀 있지 않은가 (한글 깨짐 위험)
- [ ] 비주얼 톤이 어둡거나 무섭지 않은가 (코퍼릿 풍자라도 외관은 친절·따뜻)
- [ ] 사이즈가 카테고리 기준 안에 있는가
- [ ] `art_style: "Vector Art"` + `augment_prompt: false`로 호출했는가
