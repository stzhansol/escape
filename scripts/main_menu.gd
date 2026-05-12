extends Control

@onready var btn_clock_in:  TextureButton = $ButtonsColumn/BtnClockIn
@onready var btn_resume:    TextureButton = $ButtonsColumn/BtnResume
@onready var btn_records:   TextureButton = $ButtonsColumn/BtnRecords
@onready var btn_clock_out: TextureButton = $ButtonsColumn/BtnClockOut

@onready var lbl_clock_in:  Label = $ButtonsColumn/BtnClockIn/Label
@onready var lbl_resume:    Label = $ButtonsColumn/BtnResume/Label
@onready var lbl_records:   Label = $ButtonsColumn/BtnRecords/Label
@onready var lbl_clock_out: Label = $ButtonsColumn/BtnClockOut/Label

@onready var logo_group:       Control            = $LogoGroup
@onready var ceo_mascot:       TextureRect        = $CeoMascot
@onready var title_sub:        Label              = $LogoGroup/TitleSubLabel
@onready var lbl_company:      Label              = $LogoGroup/TitleLogo/LblCompanyName
@onready var save_fail_banner: PanelContainer     = $SaveFailBanner
@onready var save_fail_label:  Label              = $SaveFailBanner/BannerBg/SaveFailLabel
@onready var wip_dialog:       AcceptDialog       = $WipDialog
@onready var overwrite_dialog: ConfirmationDialog = $OverwriteDialog

const MASCOT_SLIDE_PX := 60.0

const IDLE_SHEET_PATH      := "res://assets/main_menu/ui_title_ceo_mascot_idle_sheet.png"
const IDLE_FRAMES_PER_ROW  := 4
const IDLE_TOTAL_FRAMES    := 16
const IDLE_DURATION        := 1.67           # 시트 한 사이클 길이 (초)
const IDLE_BUST_RATIO      := 0.6            # 각 프레임의 위 60%만 사용 (상반신만 노출)

var _idle_atlas: AtlasTexture
var _idle_frame_size: Vector2 = Vector2.ZERO
var _idle_elapsed: float = 0.0
var _idle_current_frame: int = -1


func _ready() -> void:
    _apply_labels()
    _wire_buttons()
    _refresh_resume_state()
    _refresh_save_banner()
    _play_intro()
    _start_mascot_idle()
    btn_clock_in.grab_focus()


func _apply_labels() -> void:
    title_sub.text       = MessagesDB.get_text(&"menu_title_subtitle")
    lbl_company.text     = GameConfig.COMPANY_NAME
    lbl_clock_in.text    = MessagesDB.get_text(&"menu_btn_clock_in")
    lbl_resume.text      = MessagesDB.get_text(&"menu_btn_resume")
    lbl_records.text     = MessagesDB.get_text(&"menu_btn_records")
    lbl_clock_out.text   = MessagesDB.get_text(
        &"menu_btn_clock_out_web" if OS.has_feature("web") else &"menu_btn_clock_out"
    )
    save_fail_label.text = MessagesDB.get_text(&"save_blocked_banner")

    wip_dialog.title                   = MessagesDB.get_text(&"dialog_wip_title")
    wip_dialog.dialog_text             = MessagesDB.get_text(&"dialog_wip_body")
    wip_dialog.ok_button_text          = MessagesDB.get_text(&"dialog_ok")
    overwrite_dialog.title             = MessagesDB.get_text(&"dialog_overwrite_save_title")
    overwrite_dialog.dialog_text       = MessagesDB.get_text(&"dialog_overwrite_save_body")
    overwrite_dialog.ok_button_text    = MessagesDB.get_text(&"dialog_ok")
    overwrite_dialog.cancel_button_text = MessagesDB.get_text(&"dialog_cancel")


func _wire_buttons() -> void:
    btn_clock_in.pressed.connect(_on_clock_in)
    btn_resume.pressed.connect(_on_resume)
    btn_records.pressed.connect(_on_records)
    btn_clock_out.pressed.connect(_on_clock_out)
    overwrite_dialog.confirmed.connect(_start_new_game)


func _refresh_resume_state() -> void:
    var enabled := GameState.has_save()
    btn_resume.disabled = not enabled
    btn_resume.modulate.a = 1.0 if enabled else 0.45


func _refresh_save_banner() -> void:
    save_fail_banner.visible = GameState.save_blocked
    if not GameState.save_failed.is_connected(_on_save_failed):
        GameState.save_failed.connect(_on_save_failed)


func _on_save_failed(_reason: String) -> void:
    save_fail_banner.visible = true


# ─── Button handlers ───────────────────────────────────────────────────

func _on_clock_in() -> void:
    if GameState.has_save():
        overwrite_dialog.popup_centered()
    else:
        _start_new_game()


func _start_new_game() -> void:
    GameState.reset_for_new_game(true)
    # office.tscn 미구현 — WIP 알림
    _show_wip()


func _on_resume() -> void:
    if not GameState.load_save():
        _show_wip()
        return
    # 저장된 씬으로 전환 — 아직 office 등 씬이 없으므로 WIP
    _show_wip()


func _on_records() -> void:
    SceneManager.change_scene("res://scenes/records.tscn", false)


func _on_clock_out() -> void:
    if OS.has_feature("web"):
        # Web 빌드에서는 메뉴 유지 (실제 종료 X)
        return
    SceneManager.quit_or_main()


func _show_wip() -> void:
    wip_dialog.popup_centered()


# ─── Intro animation ──────────────────────────────────────────────────

func _play_intro() -> void:
    # 초기 상태: 보이지 않고 마스코트는 우측 살짝 더 바깥
    logo_group.modulate.a = 0.0
    ceo_mascot.modulate.a = 0.0
    var mascot_target_offset_left := ceo_mascot.offset_left
    var mascot_target_offset_right := ceo_mascot.offset_right
    ceo_mascot.offset_left  = mascot_target_offset_left + MASCOT_SLIDE_PX
    ceo_mascot.offset_right = mascot_target_offset_right + MASCOT_SLIDE_PX

    var buttons: Array[TextureButton] = [btn_clock_in, btn_resume, btn_records, btn_clock_out]
    for b in buttons:
        b.modulate.a = 0.0

    var t := create_tween()
    t.set_parallel(true)

    # Logo 페이드인 (0.3s)
    t.tween_property(logo_group, "modulate:a", 1.0, 0.3) \
        .set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

    # Mascot 페이드 + 우측에서 슬라이드인 (0.4s, 0.1s 지연)
    t.tween_property(ceo_mascot, "modulate:a", 1.0, 0.4).set_delay(0.1)
    t.tween_property(ceo_mascot, "offset_left", mascot_target_offset_left, 0.4) \
        .set_delay(0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
    t.tween_property(ceo_mascot, "offset_right", mascot_target_offset_right, 0.4) \
        .set_delay(0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

    # Buttons 순차 페이드인 (각 0.2s, 0.1s 간격으로 시작)
    for i in buttons.size():
        t.tween_property(buttons[i], "modulate:a", 1.0, 0.25) \
            .set_delay(0.35 + i * 0.1) \
            .set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _start_mascot_idle() -> void:
    # animateSprite로 생성된 16프레임 시트(2048×2048)를 AtlasTexture region 갱신으로 재생
    var sheet: Texture2D = load(IDLE_SHEET_PATH)
    if sheet == null:
        return
    var sheet_size := sheet.get_size()
    _idle_frame_size = Vector2(
        sheet_size.x / float(IDLE_FRAMES_PER_ROW),
        sheet_size.y / float(IDLE_FRAMES_PER_ROW),
    )
    _idle_atlas = AtlasTexture.new()
    _idle_atlas.atlas = sheet
    _idle_atlas.region = Rect2(0, 0, _idle_frame_size.x, _idle_frame_size.y * IDLE_BUST_RATIO)
    ceo_mascot.texture = _idle_atlas
    _idle_elapsed = 0.0
    _idle_current_frame = 0
    set_process(true)


func _process(delta: float) -> void:
    if _idle_atlas == null:
        return
    _idle_elapsed += delta
    var per_frame := IDLE_DURATION / float(IDLE_TOTAL_FRAMES)
    var f := int(_idle_elapsed / per_frame) % IDLE_TOTAL_FRAMES
    if f == _idle_current_frame:
        return
    _idle_current_frame = f
    var col := f % IDLE_FRAMES_PER_ROW
    var row := f / IDLE_FRAMES_PER_ROW
    _idle_atlas.region = Rect2(
        col * _idle_frame_size.x,
        row * _idle_frame_size.y,
        _idle_frame_size.x,
        _idle_frame_size.y * IDLE_BUST_RATIO,
    )
