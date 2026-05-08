---
name: game-ui-designer
description: "Godot 4.x 기반 방탈출 게임 UI/UX 설계 스킬. HUD, 인벤토리 인터페이스, 메뉴, 힌트 팝업 레이아웃 설계. 'UI 만들어줘', '인벤토리 UI', 'HUD 설계', '메뉴 화면', '인터페이스 설계', '버튼 레이아웃' 요청 시 반드시 이 스킬을 사용할 것."
---

# Game UI Designer — Godot 4.x UI 설계

## 방탈출 게임 UI 구성

방탈출 특성: UI는 최소화하여 몰입감 유지. 필수 요소만 표시.

### 핵심 UI 화면

| 화면 | 씬 파일 | 표시 조건 |
|------|---------|---------|
| HUD | `hud.tscn` | 게임 중 항상 표시 |
| 인벤토리 | `inventory.tscn` | 버튼 클릭 시 팝업 |
| 오브젝트 설명 | `examine_popup.tscn` | 오브젝트 클릭 시 |
| 힌트 | `hint_popup.tscn` | 힌트 버튼 클릭 시 |
| 일시정지 | `pause_menu.tscn` | ESC 키 |
| 메인 메뉴 | `main_menu.tscn` | 게임 시작/종료 |

---

## HUD 레이아웃

```
┌─────────────────────────────────────────────┐
│ [🎒 인벤토리]                    [💡 힌트] [⏸] │  ← 상단 바
├─────────────────────────────────────────────┤
│                                             │
│              게임 화면 (방)                   │
│                                             │
└─────────────────────────────────────────────┘
│  "낡은 열쇠를 획득했습니다."                    │  ← 하단 메시지 (일시 표시)
└─────────────────────────────────────────────┘
```

**Godot Control 노드 구조:**

```
HUD (CanvasLayer)
└── MarginContainer
    ├── TopBar (HBoxContainer)
    │   ├── InventoryButton (Button)  # 인벤토리 열기
    │   ├── Spacer (Control, size_flags = EXPAND)
    │   ├── HintButton (Button)       # 힌트 보기
    │   └── PauseButton (Button)      # 일시정지
    └── BottomMessage (Label)         # 획득/이벤트 메시지, 3초 후 숨김
```

---

## 인벤토리 UI 레이아웃

```
┌─────────────────────────────────────────────┐
│  인벤토리                              [✕]   │
├──────┬──────┬──────┬──────┬──────┬──────────┤
│ 🔑   │ 📄   │      │      │      │          │  ← 아이템 슬롯 (8개)
│열쇠  │쪽지  │      │      │      │          │
├──────┴──────┴──────┴──────┴──────┴──────────┤
│  선택: 열쇠 — 낡은 황동 열쇠                   │  ← 선택 아이템 설명
└─────────────────────────────────────────────┘
```

**Godot Control 노드 구조:**

```
InventoryPopup (Panel)
├── VBoxContainer
│   ├── Header (HBoxContainer)
│   │   ├── TitleLabel (Label)
│   │   └── CloseButton (Button)
│   ├── SlotGrid (GridContainer, columns=4)
│   │   ├── Slot0 (Panel + TextureRect + Label)
│   │   ├── Slot1 ...
│   │   └── (8개 슬롯)
│   └── ItemDescription (Label)
```

---

## 오브젝트 조사 팝업 레이아웃

```
┌─────────────────────────────┐
│  [오브젝트 이미지/아이콘]       │
│                             │
│  "서랍이 잠겨 있습니다.          │
│   번호 자물쇠가 달려 있네요."    │
│                             │
│           [닫기]             │
└─────────────────────────────┘
```

---

## 메인 메뉴 레이아웃

```
┌─────────────────────────────┐
│                             │
│      [게임 타이틀]             │
│                             │
│         [새 게임]             │
│         [계속하기]             │
│         [종료]               │
│                             │
└─────────────────────────────┘
```

**Godot Control 노드 구조:**

```
MainMenu (Control)
└── CenterContainer
    └── VBoxContainer
        ├── TitleLabel (Label)
        ├── NewGameButton (Button)
        ├── ContinueButton (Button)
        └── QuitButton (Button)
```

---

## Godot UI 핵심 노드 빠른 참조

자세한 노드 설명: [godot-ui-guide.md](references/godot-ui-guide.md)

| 노드 | 용도 |
|------|------|
| `CanvasLayer` | 씬 위에 UI 오버레이 (HUD) |
| `Control` | 모든 UI 노드의 기본 |
| `Panel` | 배경 있는 컨테이너 |
| `VBoxContainer` | 세로 정렬 |
| `HBoxContainer` | 가로 정렬 |
| `GridContainer` | 격자 정렬 (인벤토리 슬롯) |
| `Label` | 텍스트 표시 |
| `Button` | 클릭 가능한 버튼 |
| `TextureRect` | 이미지 표시 |
| `MarginContainer` | 여백 추가 |
