# UI Layout — 「퇴근 승인 바랍니다」

> 모든 좌표는 `style-guide.md` 기준 base 1920×1080 픽셀.
> Godot Control 노드 + Sprite2D/TextureRect 조합으로 표현 가능한 구조로만 작성.

---

## 1. main_menu.tscn (타이틀 화면)

### 1.1 와이어프레임

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│  ┌──────────────────────┐                              ┌─────────────────┐ │
│  │                      │                              │                 │ │
│  │ 「{COMPANY_NAME}」   │                              │   ╭───────╮     │ │
│  │   퇴근 승인 바랍니다 │                              │   │  🐰   │     │ │
│  │                      │                              │   │ 정장  │     │ │
│  └──────────────────────┘                              │   │ 핑크  │     │ │
│   (logo 480×260,                                       │   │ 토끼  │     │ │
│    top-left, anchor LT)                                │   ╰───────╯     │ │
│                                                        │   사장 마스코트 │ │
│                                                        │   (640×960,     │ │
│                                                        │    right-center)│ │
│                                                        └─────────────────┘ │
│                                                                             │
│                                                                             │
│                      ┌──────────────────────────────┐                       │
│                      │         출근하기              │   ← 580×128           │
│                      └──────────────────────────────┘                       │
│                                                                             │
│                      ┌──────────────────────────────┐                       │
│                      │         업무 복귀             │   ← 580×128 (조건부)  │
│                      └──────────────────────────────┘     세이브 없으면     │
│                                                           반투명 비활성    │
│                      ┌──────────────────────────────┐                       │
│                      │       인사 평가 기록          │   ← 580×128           │
│                      └──────────────────────────────┘                       │
│                                                                             │
│                      ┌──────────────────────────────┐                       │
│                      │         퇴근하기              │   ← 580×128           │
│                      └──────────────────────────────┘                       │
│                                                                             │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ ※ 사내 시스템 접근이 차단되어 있습니다. 세션 동안만 진행이 유지됩니다.│ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│   (bottom safe area, 조건부, ui_savefail_banner)                            │
└─────────────────────────────────────────────────────────────────────────────┘
                                                                  배경: ui_title_bg
```

### 1.2 Control 노드 구조

```
MainMenu (Control, root, anchor full rect)
├─ Background (TextureRect, anchor full rect, expand=keep_aspect_covered)
│   └─ texture = ui_title_bg
├─ LogoGroup (HBoxContainer / VBoxContainer 또는 Control)
│   ├─ anchor_left=0, anchor_top=0, anchor_right=0, anchor_bottom=0
│   ├─ offset_left=80, offset_top=80   (좌상단 + 64 safe + 16 여백)
│   └─ children
│       ├─ TitleLogo (TextureRect)
│       │   └─ texture = ui_title_logo, size 480×260
│       └─ TitleSubLabel (Label, "퇴근 승인 바랍니다")
│           └─ horizontal align center, font 36, color Ink Charcoal
├─ CeoMascot (TextureRect)
│   ├─ anchor_left=1.0, anchor_top=0.5, anchor_right=1.0, anchor_bottom=0.5
│   ├─ offset_left=-720, offset_top=-480, offset_right=-80, offset_bottom=480
│   └─ texture = ui_title_ceo_mascot, size 640×960 (top-center 기준)
├─ ButtonsColumn (VBoxContainer)
│   ├─ anchor center (h: 0.5, v: 0.5)
│   ├─ offset_left=-290, offset_top=-320, offset_right=290, offset_bottom=320
│   ├─ separation 32
│   └─ children (각 TextureButton, 텍스처는 모두 ui_btn_default 공유, Label은 font 40)
│       ├─ BtnClockIn   (size 580×128, Label "출근하기")
│       ├─ BtnResume    (size 580×128, Label "업무 복귀", disabled 시 modulate alpha 0.45)
│       ├─ BtnRecords   (size 580×128, Label "인사 평가 기록")
│       └─ BtnClockOut  (size 580×128, Label "퇴근하기" / Web에서 "메인으로")
└─ SaveFailBanner (PanelContainer + Label, 조건부 visible)
    ├─ anchor_left=0, anchor_top=1.0, anchor_right=1.0, anchor_bottom=1.0
    ├─ offset_left=64, offset_top=-120, offset_right=-64, offset_bottom=-64
    └─ texture = ui_savefail_banner, height 56
```

### 1.3 버튼 라벨 & 상호작용

| 노드 | 라벨 텍스트 (Godot Label 오버레이) | 클릭 동작 |
|------|-----------------------------------|-----------|
| BtnClockIn | `출근하기` | 세이브 없으면 즉시 office.tscn / 있으면 덮어쓰기 확인 다이얼로그 → office.tscn |
| BtnResume | `업무 복귀` | `GameState.load_save()` → 저장된 씬으로. 세이브 없으면 비활성 (modulate.a=0.45, disabled=true) |
| BtnRecords | `인사 평가 기록` | `change_scene_to_file("res://scenes/records.tscn")` |
| BtnClockOut | `퇴근하기` | Desktop/Android: `get_tree().quit()` / Web (`OS.has_feature("web")`): 라벨 자동 `메인으로`로 분기 |

텍스트는 자산에 그리지 않고 Godot Label로 오버레이 — 자산 `ui_btn_*`은 빈 둥근 사각 버튼 프레임만.

### 1.4 입력/포커스

- 마우스/터치: 각 버튼 hitbox = 자산 크기 460×96 + padding 8 (총 476×112)
- 키보드: TabFocus 순서 = ClockIn → Resume → Records → ClockOut, BtnClockIn 기본 grab_focus
- 호버 효과 사용 안 함 — 대신 `pressed`와 `disabled` 두 상태만 자산으로 (`_pressed`, `_disabled` 접미사)

### 1.5 애니메이션

- 진입 시 LogoGroup 페이드인 0.3s, CeoMascot 우측 슬라이드인 0.4s (offset_right −60 → 0), ButtonsColumn 순차 페이드인 (각 0.1s 지연)
- 사장 마스코트 idle 호흡 애니메이션: scale 1.0 ↔ 1.02, 2.4s loop
- 버튼 hover/pressed 모방: pressed 시 scale 0.97, 80ms ease

### 1.6 자산 의존 (`asset-manifest.md` ID)

`ui_title_bg`, `ui_title_logo`, `ui_title_ceo_mascot`, `ui_btn_clock_in`, `ui_btn_resume`, `ui_btn_records`, `ui_btn_clock_out`, `ui_savefail_banner`

---

---

## 2. records.tscn (인사 평가 기록 — 해금 엔딩 목록)

### 2.1 와이어프레임

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  [  인사 평가 기록  ]                                       ┌────────────┐ │
│   (헤더 라벨, font 48, top:60)                              │  돌아가기  │ │
│                                                             └────────────┘ │
│                                                                             │
│   ┌────────────────────┐    ┌────────────────────┐                          │
│   │  완벽한 직원        │    │  정상 퇴근          │                          │
│   │  "내일 08:50…"      │    │  "평범한 저녁…"     │                          │
│   │   [클리어 시각]     │    │   [클리어 시각]     │                          │
│   └────────────────────┘    └────────────────────┘                          │
│                                                                             │
│   ┌────────────────────┐    ┌────────────────────┐                          │
│   │  야근                │    │  ???                 │                         │
│   │  "조금만 더…"        │    │  소소한 반항이…      │                         │
│   └────────────────────┘    └────────────────────┘                          │
│                                                                             │
│   ┌────────────────────┐    ┌────────────────────┐                          │
│   │  ???                 │    │  ???                 │                         │
│   │  결재는 우리가…      │    │  지나친 순응의 끝   │                         │
│   └────────────────────┘    └────────────────────┘                          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
                                                              배경: ui_records_bg
```

### 2.2 Control 노드 구조

```
Records (Control, root, anchor full rect)
├─ Background (TextureRect, anchor full rect, expand=keep_aspect_covered)
│   └─ texture = ui_records_bg
├─ Header (Control, top band)
│   ├─ offset_top=60, offset_left=80
│   ├─ TitleLabel (Label, "인사 평가 기록", font 48 Bold)
│   └─ BtnBack (TextureButton, top-right, size 280×80)
│       ├─ anchor_left=1, anchor_right=1, offset_left=-360, offset_top=40
│       ├─ texture_normal = ui_btn_default (공유)
│       └─ Label ("돌아가기", font 28 Bold)
└─ CardGrid (GridContainer, columns=2)
    ├─ anchor center-h, offset_top=200
    ├─ offset_left=-620, offset_right=620   (1240 wide centered)
    ├─ theme_override_constants/h_separation=40
    ├─ theme_override_constants/v_separation=40
    └─ 6 × Card (Control, custom_minimum_size=580×240)
        ├─ CardBg (TextureRect, full rect, texture=ui_records_card_template)
        ├─ NameLabel  (Label, anchor top, font 28 Bold, top:40 left:40)
        ├─ PreviewLabel (Label, anchor center, font 22 Regular, 본문 영역)
        └─ MetaLabel (Label, anchor bottom-right, font 18 Regular, "첫 클리어 ____")
```

### 2.3 카드 데이터 바인딩

- 데이터 소스: `GameState.endings_unlocked` + 엔딩 6종 표 (GDD §6: `id` / `name` / `last_text` / `lock_hint`)
- 카드 6개는 GDD §6 표 순서대로 (`perfect`, `normal`, `overtime`, `kaltte`, `resign`, `drone`)
- **해금 카드**: NameLabel = 엔딩 이름, PreviewLabel = `last_text` 미리보기, MetaLabel = `"첫 클리어 {time}"` (현재는 saved_at)
- **잠금 카드**: NameLabel = `"???"`, PreviewLabel = `lock_hint`, MetaLabel 숨김, 카드 modulate.a = 0.7 (살짝 톤다운)
- 클릭 동작:
  - 해금 카드 → AcceptDialog로 last_text 전체를 표시
  - 잠금 카드 → 잠금 힌트를 한 번 더 강조 표시 (또는 nop)

### 2.4 입력/포커스

- 카드는 클릭 가능 — Control에 mouse_filter=STOP + gui_input 받음, 또는 TextureButton 위에 카드 텍스처 얹기
- TabFocus 순서: BtnBack → Card[0]..Card[5]
- ESC 키 = BtnBack과 동일 동작 (main_menu로 복귀)

### 2.5 자산 의존 (`asset-manifest.md` ID)

`ui_records_bg`, `ui_records_card_template`, `ui_btn_back`(=ui_btn_default 공유)

---

> 다른 씬(office, …)의 ui-layout은 후속 합의 시 추가.
