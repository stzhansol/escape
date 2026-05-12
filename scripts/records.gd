extends Control

# GDD §6 엔딩 6종. 변경 시 GDD와 동기 유지.
const ENDINGS: Array[Dictionary] = [
    {
        "id": &"ending_perfect",
        "name": "완벽한 직원",
        "last_text": "내일 08:50 회의가 등록되었습니다.",
        "lock_hint": "성실의 끝, 그러나…",
    },
    {
        "id": &"ending_normal",
        "name": "정상 퇴근",
        "last_text": "평범한 저녁이 시작되었다.",
        "lock_hint": "평범하게 살기란 어렵다",
    },
    {
        "id": &"ending_overtime",
        "name": "야근",
        "last_text": "조금만 더 하면 끝납니다.",
        "lock_hint": "다 못 끝낸 일이 있다면…",
    },
    {
        "id": &"ending_kaltte",
        "name": "칼퇴",
        "last_text": "생각보다 문은 쉽게 열렸다.",
        "lock_hint": "소소한 반항이 쌓이면…",
    },
    {
        "id": &"ending_resign",
        "name": "퇴사",
        "last_text": "승인은 필요 없었다.",
        "lock_hint": "결재는 우리가 만든다",
    },
    {
        "id": &"ending_drone",
        "name": "회사의 일부",
        "last_text": "플레이어가 NPC 직원이 되었습니다.",
        "lock_hint": "지나친 순응의 끝",
    },
]

@onready var card_grid: GridContainer    = $CardGrid
@onready var btn_back:  TextureButton    = $Header/BtnBack
@onready var detail:    AcceptDialog     = $DetailDialog


func _ready() -> void:
    btn_back.pressed.connect(_on_back)
    $Header/BtnBack/Label.text = "돌아가기"
    $Header/TitleLabel.text    = "인사 평가 기록"
    detail.ok_button_text      = MessagesDB.get_text(&"dialog_ok")

    for i in ENDINGS.size():
        var card := card_grid.get_node("Card%d" % i)
        var data: Dictionary = ENDINGS[i]
        var unlocked := GameState.endings_unlocked.has(data["id"])
        _bind_card(card, data, unlocked)


func _bind_card(card: Control, data: Dictionary, unlocked: bool) -> void:
    var name_label:    Label = card.get_node("NameLabel")
    var preview_label: Label = card.get_node("PreviewLabel")
    var meta_label:    Label = card.get_node("MetaLabel")

    if unlocked:
        name_label.text    = data["name"]
        preview_label.text = data["last_text"]
        meta_label.text    = ""
        meta_label.visible = false
        card.modulate.a    = 1.0
    else:
        name_label.text    = "???"
        preview_label.text = data["lock_hint"]
        meta_label.text    = ""
        meta_label.visible = false
        card.modulate.a    = 0.72

    # 카드 자체를 클릭 가능하게
    if not card.gui_input.is_connected(_on_card_input):
        card.mouse_filter = Control.MOUSE_FILTER_STOP
        card.gui_input.connect(_on_card_input.bind(data, unlocked))


func _on_card_input(event: InputEvent, data: Dictionary, unlocked: bool) -> void:
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        _show_detail(data, unlocked)
    elif event is InputEventScreenTouch and event.pressed:
        _show_detail(data, unlocked)


func _show_detail(data: Dictionary, unlocked: bool) -> void:
    if unlocked:
        detail.title = "[ 평가 결과 — %s ]" % data["name"]
        detail.dialog_text = data["last_text"]
    else:
        detail.title = "[ 인사 평가 기록 — 미해금 ]"
        detail.dialog_text = "%s\n\n해당 항목은 아직 확정되지 않은 평가입니다." % data["lock_hint"]
    detail.popup_centered()


func _on_back() -> void:
    SceneManager.change_scene("res://scenes/main_menu.tscn", false)


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        _on_back()
