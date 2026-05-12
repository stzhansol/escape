extends Node

const SAVE_PATH := "user://save.json"
const VERSION   := "1.0"

const TIME_COST := {
    &"puzzle_solved":   3,
    &"puzzle_failed":   5,
    &"scene_change":    2,
    &"choice_made":     1,
    &"clue_first_tap":  1,
    &"clue_repeat_tap": 0,
    &"inventory_use":   0,
}

signal time_changed(minutes_left: int, delta: int)
signal time_expired
signal save_succeeded
signal save_failed(reason: String)

var accuracy: int           = 0
var stress: int             = 0
var resistance: int         = 0
var conformity: int         = 0
var overtime_flag: int      = 0
var hidden_clues: Array     = []
var time_remaining: int     = 540   # 09:00 → 18:00, 분 단위
var inventory: Array        = []
var puzzles_cleared: Array  = []
var endings_unlocked: Array = []
var current_scene: String   = ""
var save_blocked: bool      = false


func consume_time(event: StringName) -> void:
    var delta: int = TIME_COST.get(event, 0)
    if delta <= 0:
        return
    time_remaining = max(0, time_remaining - delta)
    time_changed.emit(time_remaining, -delta)
    if time_remaining == 0:
        time_expired.emit()


func unlock_ending(id: StringName) -> void:
    if id in endings_unlocked:
        return
    endings_unlocked.append(id)
    autosave()


func has_save() -> bool:
    return FileAccess.file_exists(SAVE_PATH)


func autosave() -> void:
    var data := _serialize()
    var f := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if f == null:
        save_blocked = true
        save_failed.emit("filesystem_blocked")
        return
    f.store_string(JSON.stringify(data, "\t"))
    save_blocked = false
    save_succeeded.emit()


func load_save() -> bool:
    if not has_save():
        return false
    var f := FileAccess.open(SAVE_PATH, FileAccess.READ)
    if f == null:
        return false
    var parsed = JSON.parse_string(f.get_as_text())
    if typeof(parsed) != TYPE_DICTIONARY:
        return false
    _deserialize(parsed)
    return true


func reset_for_new_game(keep_endings_unlocked: bool = true) -> void:
    var prior_endings: Array = endings_unlocked.duplicate() if keep_endings_unlocked else []
    accuracy = 0
    stress = 0
    resistance = 0
    conformity = 0
    overtime_flag = 0
    hidden_clues = []
    time_remaining = 540
    inventory = []
    puzzles_cleared = []
    current_scene = ""
    endings_unlocked = prior_endings


func _serialize() -> Dictionary:
    return {
        "version": VERSION,
        "saved_at": Time.get_datetime_string_from_system(),
        "scene": current_scene,
        "state": {
            "accuracy": accuracy,
            "stress": stress,
            "resistance": resistance,
            "conformity": conformity,
            "overtime_flag": overtime_flag,
            "hidden_clues": hidden_clues,
            "time_remaining": time_remaining,
        },
        "inventory": inventory,
        "puzzles_cleared": puzzles_cleared,
        "endings_unlocked": endings_unlocked,
    }


func _deserialize(d: Dictionary) -> void:
    current_scene    = d.get("scene", "")
    var s: Dictionary = d.get("state", {})
    accuracy         = int(s.get("accuracy", 0))
    stress           = int(s.get("stress", 0))
    resistance       = int(s.get("resistance", 0))
    conformity       = int(s.get("conformity", 0))
    overtime_flag    = int(s.get("overtime_flag", 0))
    hidden_clues     = s.get("hidden_clues", [])
    time_remaining   = int(s.get("time_remaining", 540))
    inventory        = d.get("inventory", [])
    puzzles_cleared  = d.get("puzzles_cleared", [])
    endings_unlocked = d.get("endings_unlocked", [])
