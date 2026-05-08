# Godot 4.x UI 노드 가이드

## 목차
1. [레이아웃 컨테이너](#1-레이아웃-컨테이너)
2. [앵커와 크기 설정](#2-앵커와-크기-설정)
3. [팝업 처리](#3-팝업-처리)
4. [버튼 이벤트](#4-버튼-이벤트)
5. [테마와 스타일](#5-테마와-스타일)

---

## 1. 레이아웃 컨테이너

### VBoxContainer / HBoxContainer
자식 노드를 세로/가로로 자동 정렬.

```gdscript
# 코드에서 동적으로 버튼 추가
var button = Button.new()
button.text = "클릭"
$VBoxContainer.add_child(button)
```

### GridContainer
격자로 정렬. `columns` 속성으로 열 수 지정.

```gdscript
# 인벤토리 슬롯 8개 생성
$GridContainer.columns = 4  # 4x2 격자
```

### CenterContainer
자식 노드를 중앙 정렬.

### MarginContainer
내부 여백 추가. Inspector에서 `Theme Overrides > Constants`로 마진 설정.

---

## 2. 앵커와 크기 설정

### 전체 화면 채우기
```gdscript
# 스크립트에서
control_node.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
```

Inspector에서: Anchor Preset → "Full Rect"

### 상단 바 고정
- Top: 0, Bottom: 60px 고정
- Anchor Preset → "Top Wide"

### 중앙 팝업
- Anchor Preset → "Center"
- Custom Minimum Size 설정 (예: 400x300)

---

## 3. 팝업 처리

### 팝업 열기/닫기 패턴

```gdscript
# inventory_ui.gd
extends Control

func _ready() -> void:
    visible = false
    $CloseButton.pressed.connect(hide)

func open() -> void:
    visible = true
    _refresh_slots()
```

```gdscript
# hud.gd에서 인벤토리 열기
func _on_inventory_button_pressed() -> void:
    $InventoryPopup.open()
```

### ESC로 팝업 닫기

```gdscript
func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel") and visible:
        hide()
        get_viewport().set_input_as_handled()
```

---

## 4. 버튼 이벤트

```gdscript
# Inspector에서 연결하는 방법: 버튼 선택 → Node 탭 → pressed() 더블클릭

# 코드에서 연결하는 방법
$NewGameButton.pressed.connect(_on_new_game_pressed)

func _on_new_game_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/rooms/room_01.tscn")
```

---

## 5. 테마와 스타일

### 빠른 스타일 적용 (인라인)

```gdscript
# 버튼 배경색 변경
var style = StyleBoxFlat.new()
style.bg_color = Color(0.2, 0.2, 0.2, 0.8)
style.corner_radius_top_left = 8
$Panel.add_theme_stylebox_override("panel", style)
```

### 폰트 크기 변경

```gdscript
$Label.add_theme_font_size_override("font_size", 18)
```

### 3초 후 메시지 숨기기 (HUD 알림)

```gdscript
# hud.gd
func show_message(text: String) -> void:
    $BottomMessage.text = text
    $BottomMessage.visible = true
    await get_tree().create_timer(3.0).timeout
    $BottomMessage.visible = false
```
