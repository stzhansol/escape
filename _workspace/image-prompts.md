# 퇴근 승인 바랍니다 — AI 이미지 생성 프롬프트

AI 이미지 생성 도구(Midjourney, DALL-E 3, Stable Diffusion)에 바로 붙여넣기용.

---

## 공통 스타일 블록 (모든 프롬프트에 뒤에 붙일 것)

```
flat vector illustration, simple 2D game background art,
clean geometric shapes, minimal detail, no text no letters no signs,
muted desaturated color palette, solid color fills, no gradients,
empty room no characters, point-and-click adventure game style,
16:9 widescreen
```

> **핵심 변경:** `no text no letters no signs` 로 한글 깨짐 방지.  
> `flat vector` + `simple geometric` + `solid color fills` 로 사진 느낌 제거.

---

## 씬 배경 이미지 (5개)

---

### 1. 사무실 (office) — 메인 씬

```
office room interior, rows of gray desks with boxy CRT monitors,
beige walls with a bulletin board, fluorescent ceiling lights,
paper stacks on desks, wall clock, no text no letters no signs,
flat vector illustration, simple 2D game background art,
clean geometric shapes, minimal detail,
muted desaturated color palette (off-white beige, steel gray, dark charcoal),
solid color fills, no gradients, empty room no characters,
point-and-click adventure game style, 16:9 widescreen
```

---

### 2. 회의실 (meeting_room)

```
conference room interior, long rectangular table, empty chairs around it,
blank whiteboard on wall, ceiling projector, cold blue-tinted walls,
no text no letters no signs,
flat vector illustration, simple 2D game background art,
clean geometric shapes, minimal detail,
muted color palette (cool gray, navy blue, off-white),
solid color fills, no gradients, empty room no characters,
point-and-click adventure game style, 16:9 widescreen
```

---

### 3. 복사실 (copy_room)

```
small windowless copy room, large boxy photocopier machine in center,
shelves with binders, papers scattered on floor, single ceiling light,
no text no letters no signs,
flat vector illustration, simple 2D game background art,
clean geometric shapes, minimal detail,
muted color palette (concrete gray, warm beige, dim white),
solid color fills, no gradients, empty room no characters,
point-and-click adventure game style, 16:9 widescreen
```

---

### 4. 탕비실 (break_room)

```
office break room interior, large refrigerator against wall,
microwave and coffee machine on counter, paper cup dispenser,
cream colored walls, warm yellow ceiling light,
no text no letters no signs,
flat vector illustration, simple 2D game background art,
clean geometric shapes, minimal detail,
muted warm color palette (cream white, warm yellow, gray),
solid color fills, no gradients, empty room no characters,
point-and-click adventure game style, 16:9 widescreen
```

---

### 5. 비상계단 (hidden_staircase) — 히든 루트

```
dark emergency stairwell, concrete walls, metal stairs going down,
green exit sign glowing, single dim red emergency light on ceiling,
rusty metal door, high contrast shadows,
no text no letters no signs,
flat vector illustration, simple 2D game background art,
clean geometric shapes, minimal detail,
dark color palette (near black, dark charcoal, amber yellow accent only on exit sign),
solid color fills, no gradients, empty no characters,
point-and-click adventure game style, 16:9 widescreen
```

---

## 엔딩 화면 이미지 (6개)

---

### 엔딩 1: 완벽한 직원

```
single office desk with glowing monitor, overexposed white room,
everything perfectly arranged, sterile and empty, no warmth,
no text no letters no signs,
flat vector illustration, simple 2D game art,
high-key white palette, cold and hollow atmosphere,
solid color fills, no gradients, 16:9 widescreen
```

---

### 엔딩 2: 정상 퇴근

```
office window at dusk, city buildings outside in dark navy blue sky,
empty desk with a bag on it, warm light from window,
no text no letters no signs,
flat vector illustration, simple 2D game art,
deep navy and soft warm yellow palette, quiet and calm,
solid color fills, no gradients, 16:9 widescreen
```

---

### 엔딩 3: 야근

```
dark office at night, all lights off except one glowing monitor,
wall clock showing late night, cold blue screen glow,
no text no letters no signs,
flat vector illustration, simple 2D game art,
very dark charcoal palette with single blue light source,
solid color fills, no gradients, 16:9 widescreen
```

---

### 엔딩 4: 칼퇴 (히든)

```
emergency stairwell door swinging open, warm golden light flooding in from outside,
dark interior silhouette, dramatic light shaft,
no text no letters no signs,
flat vector illustration, simple 2D game art,
dark interior with strong amber yellow light beam from door,
solid color fills, no gradients, 16:9 widescreen
```

---

### 엔딩 5: 퇴사 (히든)

```
pure black background, single blinking green cursor dot centered,
absolute minimalism, terminal screen aesthetic,
no text no letters no signs,
flat vector illustration, simple 2D game art,
pure black with one small green glowing element,
solid color fills, 16:9 widescreen
```

---

### 엔딩 6: 회사의 일부

```
office room interior identical to the beginning, same gray desks same monitors,
one desk now has a small nameplate object on it, nothing else changed,
no text no letters no signs,
flat vector illustration, simple 2D game art,
same muted office palette as main scene, gray and beige, subtly unsettling,
solid color fills, no gradients, 16:9 widescreen
```

---

## UI 요소 이미지 (3개)

---

### HUD 상단 바 레퍼런스

```
horizontal UI bar, dark charcoal background, small digital clock icon on left,
thin progress bar in the center, three small icon slots on right,
no text no letters no numbers,
flat vector UI design, simple clean shapes,
dark gray and steel blue color scheme,
isolated on transparent background, wide banner format
```

---

### 인벤토리 팝업 레퍼런스

```
popup window UI panel, dark header bar, grid of square item slots below,
beige-white background, thick gray borders, some slots empty some with simple icons,
one slot with golden yellow border to indicate special item,
no text no letters no signs,
flat vector UI design, retro software window style,
muted beige and navy color scheme, isolated on transparent background
```

---

### 퍼즐 팝업 프레임 레퍼런스

```
dialog box UI frame, double-line border style, dark navy header bar,
beige interior, bottom row with two button shapes,
no text no letters no signs,
flat vector UI design, retro corporate software style,
navy and beige color scheme, isolated on transparent background
```

---

## 오브젝트 클로즈업 이미지 (Examine) — 7개

클릭 시 확대되어 보여지는 오브젝트 이미지. 비율은 4:3 또는 1:1 권장.

> 공통 추가 키워드: `close-up view, centered object, slightly worn and used look`

---

### 컴퓨터 모니터 화면 (사무실 — 퍼즐 1·2·4·5·7·9 공용)

```
close-up of old boxy CRT computer monitor, screen glowing with simple grid UI layout,
dark monitor body, screen showing empty rectangular boxes and a cursor,
slightly dusty surface, centered object,
no text no letters no signs,
flat vector illustration, simple 2D game art,
dark charcoal and steel blue palette, solid color fills, no gradients,
4:3 ratio
```

---

### 책상 서랍 내부 (사무실 — 퍼즐 1 단서)

```
close-up of open desk drawer interior viewed from above,
folded paper document inside, small envelope, paper clip,
worn wooden drawer interior, centered view,
no text no letters no signs,
flat vector illustration, simple 2D game art,
warm beige and brown palette, solid color fills, no gradients,
4:3 ratio
```

---

### 포스트잇 메모 (사무실 — 퍼즐 4 단서)

```
close-up of yellow sticky note posted on beige wall,
blank yellow square, slightly curled corner, small shadow,
centered object, clean and simple,
no text no letters no signs,
flat vector illustration, simple 2D game art,
yellow and beige palette, solid color fills, no gradients,
1:1 ratio
```

---

### 화이트보드 (회의실 — 퍼즐 3)

```
close-up of office whiteboard, white surface with faint erased marks,
empty grid lines drawn in dry-erase marker style, marker tray at bottom,
no text no letters no signs,
flat vector illustration, simple 2D game art,
white and light gray palette, solid color fills, no gradients,
4:3 ratio
```

---

### 복사기 조작 패널 (복사실 — 퍼즐 6)

```
close-up of photocopier control panel, several square buttons in a row,
one small LED indicator light, paper slot visible at bottom edge,
worn plastic surface, centered view,
no text no letters no signs,
flat vector illustration, simple 2D game art,
light gray and dark charcoal palette, one red glowing dot accent,
solid color fills, no gradients, 4:3 ratio
```

---

### 냉장고 뒷면 (탕비실 — 히든 단서)

```
close-up of back of refrigerator, dusty floor gap between fridge and wall,
small folded paper note wedged in the gap, dim lighting,
slightly dark and cramped view, centered,
no text no letters no signs,
flat vector illustration, simple 2D game art,
dark gray and cream palette, amber yellow accent on the note,
solid color fills, no gradients, 4:3 ratio
```

---

### 재고표 종이 (탕비실 — 퍼즐 8)

```
close-up of paper inventory sheet pinned to wall,
simple table grid drawn on paper, rows and columns with empty cells,
slightly crumpled paper, pushpin at top corner, centered,
no text no letters no signs,
flat vector illustration, simple 2D game art,
cream white and warm gray palette, solid color fills, no gradients,
4:3 ratio
```

---

## 퍼즐 전용 이미지 — 6개

팝업 안에서 퍼즐 콘텐츠로 사용되는 이미지. 비율은 퍼즐 팝업 크기(4:3)에 맞춤.

---

### 퍼즐 2: 메일 목록 화면

```
close-up of old computer screen showing email inbox list,
rows of email entries as empty horizontal bars, sender icons as simple circles,
scrollbar on right side, top bar with folder icons,
no text no letters no signs,
flat vector illustration, simple 2D game art,
dark monitor background with light gray rows, steel blue accents,
solid color fills, no gradients, 4:3 ratio
```

---

### 퍼즐 3: 팀원 일정표

```
weekly schedule grid chart, four rows of colored horizontal bars at different time slots,
column headers as simple shapes, one time slot highlighted with a circle,
clean grid lines, no text no letters no signs,
flat vector illustration, simple 2D game art,
white background with steel blue and gray bars, solid color fills, no gradients,
4:3 ratio
```

---

### 퍼즐 5: 엑셀 스프레드시트

```
close-up of spreadsheet on monitor screen, grid of cells with empty rectangles,
column headers as simple letter shapes, one cell highlighted in yellow,
scrollbar visible on right, dark monitor frame around screen,
no text no letters no signs,
flat vector illustration, simple 2D game art,
white and light gray grid, steel blue highlights, dark monitor border,
solid color fills, no gradients, 4:3 ratio
```

---

### 퍼즐 6: 복사기 버튼 배열 (조작 순서 퍼즐)

```
flat lay of photocopier control panel, five distinct square buttons arranged in a row,
each button a different shape indicator (triangle, circle, square etc), one glowing green,
simple icon symbols only, no labels,
no text no letters no signs,
flat vector illustration, simple 2D game art,
light gray panel, buttons in charcoal and steel blue, one green accent button,
solid color fills, no gradients, 4:3 ratio
```

---

### 퍼즐 7: 결재 흐름도

```
approval flow diagram, rectangular boxes connected by arrows pointing downward,
three boxes in sequence top to bottom, connector lines with arrowheads,
empty boxes with no labels, organizational chart style,
no text no letters no signs,
flat vector illustration, simple 2D game art,
white background, navy blue boxes and arrows, solid color fills, no gradients,
4:3 ratio
```

---

### 퍼즐 8: 탕비실 재고 수량 표

```
inventory count chart, four rows each with a simple icon on left and bar graph on right,
bars of different lengths showing quantity, one bar notably shorter than others,
clean simple chart layout, no labels,
no text no letters no signs,
flat vector illustration, simple 2D game art,
cream white background, steel blue bars with varying lengths,
solid color fills, no gradients, 4:3 ratio
```

---

## 활용 팁

- **Midjourney:** 프롬프트 그대로 사용. `--ar 16:9 --style raw --no text` 추가 권장.
- **DALL-E 3:** 그대로 붙여넣기.
- **Stable Diffusion:** 네거티브 프롬프트 추가: `realistic photo, 3D render, people, text, letters, signs, gradients, complex details, anime`
- **일관성 유지:** 첫 씬 이미지 생성 후 `--seed` 값 고정하거나 같은 세션에서 연속 생성.
