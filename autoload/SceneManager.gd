extends Node

# 모든 씬 전환·앱 일시정지를 한 곳에서. 게임 씬 이동 시 GameState.consume_time(&"scene_change") 자동 호출.

signal scene_changing(from_path: String, to_path: String)
signal scene_changed(to_path: String)
signal app_paused
signal app_resumed

var is_paused: bool = false


func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS    # 일시정지 중에도 resume 받아야 함


# path: res://scenes/*.tscn
# consume_time: 게임 씬 이동에 한해 true (메뉴/엔딩 화면은 false)
func change_scene(path: String, consume_time: bool = true) -> Error:
    if not ResourceLoader.exists(path):
        push_error("SceneManager.change_scene: missing scene %s" % path)
        return ERR_FILE_NOT_FOUND

    if consume_time:
        GameState.consume_time(&"scene_change")

    var tree := get_tree()
    var from_path := ""
    if tree.current_scene != null:
        from_path = tree.current_scene.scene_file_path
    scene_changing.emit(from_path, path)

    var err := tree.change_scene_to_file(path)
    if err == OK:
        GameState.current_scene = path
        scene_changed.emit(path)
    return err


func reload_current() -> void:
    get_tree().reload_current_scene()


# 종료 — Web에서는 메인 메뉴로 분기 (실제 종료 불가)
func quit_or_main() -> void:
    if OS.has_feature("web"):
        change_scene("res://scenes/main_menu.tscn", false)
    else:
        get_tree().quit()


func _notification(what: int) -> void:
    match what:
        NOTIFICATION_APPLICATION_PAUSED, NOTIFICATION_WM_WINDOW_FOCUS_OUT:
            _enter_pause()
        NOTIFICATION_APPLICATION_RESUMED, NOTIFICATION_WM_WINDOW_FOCUS_IN:
            _exit_pause()


func _enter_pause() -> void:
    if is_paused:
        return
    is_paused = true
    get_tree().paused = true
    app_paused.emit()


func _exit_pause() -> void:
    if not is_paused:
        return
    is_paused = false
    get_tree().paused = false
    app_resumed.emit()
