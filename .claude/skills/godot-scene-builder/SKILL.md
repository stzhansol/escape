---
name: godot-scene-builder
description: "Godot 4.x 씬 구조 설계 및 GDScript 구현 스킬. 방탈출 게임의 씬 노드 계층, 인터랙션 스크립트, 시그널 연결, 씬 전환, 인벤토리/저장 시스템 구현. 'Godot 코드 짜줘', '씬 만들어줘', 'GDScript 구현', '시그널 설계', '인벤토리 구현', '저장 기능' 요청 시 반드시 이 스킬을 사용할 것."
---

# Godot Scene Builder — Godot 4.x 구현 가이드

Godot 4.x API 기준. GDScript 패턴은 [godot4-patterns.md](references/godot4-patterns.md) 참조.

## 방탈출 게임 씬 구조

### 전체 씬 트리

```
res://
├── scenes/
│   ├── main.tscn          # 게임 진입점
│   ├── rooms/
│   │   ├── room_01.tscn   # 방 1
│   │   └── room_02.tscn   # 방 2
│   ├── ui/
│   │   ├── hud.tscn       # HUD (항상 표시)
│   │   ├── inventory.tscn # 인벤토리 팝업
│   │   └── hint.tscn      # 힌트 팝업
│   └── objects/
│       ├── lockbox.tscn   # 재사용 가능한 자물쇠 상자
│       └── item.tscn      # 획득 가능한 아이템
├── scripts/
│   ├── game_state.gd      # Autoload 싱글턴
│   └── inventory.gd       # 인벤토리 로직
└── assets/
    ├── sprites/
    └── sounds/
```

### 방(Room) 씬 노드 구조

```
Room01 (Node2D)
├── Background (Sprite2D)
├── Interactables (Node2D)   # 클릭 가능한 오브젝트들
│   ├── Desk (Area2D)
│   │   ├── CollisionShape2D
│   │   └── Sprite2D
│   └── Lockbox (Area2D)     # 또는 PackedScene 인스턴스
├── ExitDoor (Area2D)
└── UI (CanvasLayer)
    └── HUD (Control)        # hud.tscn 인스턴스
```

## 핵심 구현 패턴

### 클릭 가능한 오브젝트

```gdscript
# interactable_object.gd
extends Area2D

signal object_clicked(object_name: String)

func _ready() -> void:
    input_event.connect(_on_input_event)

func _on_input_event(_viewport, event, _shape_idx) -> void:
    if event is InputEventMouseButton and event.pressed:
        object_clicked.emit(name)
```

### GameState 싱글턴 (Autoload)

```gdscript
# game_state.gd - Project Settings > Autoload에 등록
extends Node

var inventory: Array[String] = []
var puzzle_states: Dictionary = {}

func add_item(item_name: String) -> void:
    if item_name not in inventory:
        inventory.append(item_name)

func solve_puzzle(puzzle_id: String) -> void:
    puzzle_states[puzzle_id] = true

func is_puzzle_solved(puzzle_id: String) -> bool:
    return puzzle_states.get(puzzle_id, false)
```

### 씬 전환

```gdscript
# room을 전환할 때
func go_to_next_room() -> void:
    get_tree().change_scene_to_file("res://scenes/rooms/room_02.tscn")
```

### 저장/불러오기

```gdscript
# game_state.gd에 추가
const SAVE_PATH = "user://savegame.json"

func save_game() -> void:
    var data = {
        "inventory": inventory,
        "puzzle_states": puzzle_states
    }
    var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    file.store_string(JSON.stringify(data))

func load_game() -> void:
    if not FileAccess.file_exists(SAVE_PATH):
        return
    var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
    var data = JSON.parse_string(file.get_as_text())
    inventory = data.get("inventory", [])
    puzzle_states = data.get("puzzle_states", {})
```

## Autoload 설정 방법

1. Godot 에디터 → Project → Project Settings
2. Autoload 탭 → Path: `res://scripts/game_state.gd`, Name: `GameState`
3. 이후 어느 스크립트에서든 `GameState.add_item("key")` 형태로 접근 가능

PHP의 글로벌 싱글턴과 동일한 개념.

## 시그널 설계 원칙

씬 간 직접 참조(`$"/root/Room01/Desk"`) 대신 시그널 사용:
- 직접 참조는 씬 구조가 바뀌면 전부 깨짐
- 시그널은 느슨한 결합 — JS의 EventEmitter와 동일 개념

자세한 시그널 패턴 → [godot4-patterns.md](references/godot4-patterns.md)
