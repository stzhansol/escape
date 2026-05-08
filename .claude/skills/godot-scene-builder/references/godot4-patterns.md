# Godot 4.x 패턴 모음

## 목차
1. [시그널 패턴](#1-시그널-패턴)
2. [인벤토리 시스템](#2-인벤토리-시스템)
3. [퍼즐 상태 관리](#3-퍼즐-상태-관리)
4. [오브젝트 조사 팝업](#4-오브젝트-조사-팝업)
5. [숫자 자물쇠](#5-숫자-자물쇠)
6. [아이템 획득](#6-아이템-획득)
7. [조건부 씬 전환](#7-조건부-씬-전환)

---

## 1. 시그널 패턴

### 오브젝트 → HUD 연결 (씬 간 통신)

```gdscript
# room_01.gd
func _ready() -> void:
    $Interactables/Desk.object_clicked.connect(_on_object_clicked)

func _on_object_clicked(object_name: String) -> void:
    $UI/HUD.show_description("책상입니다. 서랍이 잠겨 있습니다.")
```

### 커스텀 시그널 정의

```gdscript
# puzzle_lock.gd
signal puzzle_solved(puzzle_id: String)
signal item_found(item_name: String)

func _check_answer(input: String) -> void:
    if input == correct_answer:
        puzzle_solved.emit("desk_lock")
        item_found.emit("secret_key")
```

---

## 2. 인벤토리 시스템

```gdscript
# inventory_ui.gd
extends Control

const SLOT_COUNT = 8

func _ready() -> void:
    GameState.inventory_changed.connect(_refresh)

func _refresh() -> void:
    for i in range(SLOT_COUNT):
        var slot = $SlotContainer.get_child(i)
        if i < GameState.inventory.size():
            slot.set_item(GameState.inventory[i])
        else:
            slot.clear()

func _on_slot_clicked(slot_index: int) -> void:
    if slot_index < GameState.inventory.size():
        GameState.selected_item = GameState.inventory[slot_index]
```

### GameState에 인벤토리 변경 시그널 추가

```gdscript
# game_state.gd
signal inventory_changed

func add_item(item_name: String) -> void:
    if item_name not in inventory:
        inventory.append(item_name)
        inventory_changed.emit()
```

---

## 3. 퍼즐 상태 관리

```gdscript
# 퍼즐 오브젝트가 이미 풀렸으면 비활성화
func _ready() -> void:
    if GameState.is_puzzle_solved("desk_lock"):
        $LockSprite.visible = false
        $OpenDrawer.visible = true
```

---

## 4. 오브젝트 조사 팝업

```gdscript
# examine_popup.gd
extends Panel

@onready var description_label: Label = $Description
@onready var close_button: Button = $CloseButton

func show_text(text: String) -> void:
    description_label.text = text
    visible = true

func _on_close_button_pressed() -> void:
    visible = false
```

```gdscript
# 오브젝트에서 팝업 호출
func _on_input_event(_viewport, event, _shape_idx) -> void:
    if event is InputEventMouseButton and event.pressed:
        get_tree().get_first_node_in_group("popup").show_text("낡은 책상입니다.")
```

그룹 사용: 팝업 노드를 "popup" 그룹에 추가하면 씬 구조와 무관하게 접근 가능.

---

## 5. 숫자 자물쇠

```gdscript
# number_lock.gd
extends Control

signal lock_opened

@export var correct_code: String = "1234"
@onready var input_field: LineEdit = $InputField

func _on_submit_button_pressed() -> void:
    if input_field.text == correct_code:
        lock_opened.emit()
        visible = false
    else:
        $ErrorLabel.text = "틀렸습니다."
        input_field.clear()
```

---

## 6. 아이템 획득

```gdscript
# pickupable_item.gd
extends Area2D

@export var item_name: String = "key"
@export var item_display_name: String = "낡은 열쇠"

func _ready() -> void:
    input_event.connect(_on_input_event)
    if GameState.has_item(item_name):
        visible = false

func _on_input_event(_viewport, event, _shape_idx) -> void:
    if event is InputEventMouseButton and event.pressed:
        GameState.add_item(item_name)
        visible = false
        # HUD에 획득 메시지 표시
        get_tree().get_first_node_in_group("hud").show_message(
            item_display_name + "을(를) 획득했습니다."
        )
```

GameState에 `has_item` 추가:
```gdscript
func has_item(item_name: String) -> bool:
    return item_name in inventory
```

---

## 7. 조건부 씬 전환

```gdscript
# exit_door.gd
extends Area2D

@export var required_item: String = "room1_key"
@export var next_scene: String = "res://scenes/rooms/room_02.tscn"

func _on_input_event(_viewport, event, _shape_idx) -> void:
    if not (event is InputEventMouseButton and event.pressed):
        return
    
    if GameState.has_item(required_item):
        get_tree().change_scene_to_file(next_scene)
    else:
        get_tree().get_first_node_in_group("hud").show_message("잠겨 있습니다.")
```

---

## Godot 4.x vs 3.x 주요 차이점

PHP/JS 개발자 기준 주의사항:

| 항목 | Godot 3.x (구버전) | Godot 4.x (사용 중) |
|------|-------------------|-------------------|
| 타입 힌트 | 선택적 | 권장 (`var x: int`) |
| 시그널 연결 | `.connect("signal", func)` | `.connect(func)` |
| 파일 읽기 | `File.new()` | `FileAccess.open()` |
| 씬 전환 | `get_tree().change_scene("res://...")` | `get_tree().change_scene_to_file("res://...")` |
