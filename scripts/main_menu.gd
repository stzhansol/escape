extends Control

@onready var btn_clock_in:  TextureButton = $ButtonsColumn/BtnClockIn
@onready var btn_resume:    TextureButton = $ButtonsColumn/BtnResume
@onready var btn_records:   TextureButton = $ButtonsColumn/BtnRecords
@onready var btn_clock_out: TextureButton = $ButtonsColumn/BtnClockOut

@onready var lbl_clock_in:  Label = $ButtonsColumn/BtnClockIn/Label
@onready var lbl_resume:    Label = $ButtonsColumn/BtnResume/Label
@onready var lbl_records:   Label = $ButtonsColumn/BtnRecords/Label
@onready var lbl_clock_out: Label = $ButtonsColumn/BtnClockOut/Label

@onready var title_sub:        Label              = $LogoGroup/TitleSubLabel
@onready var lbl_company:      Label              = $LogoGroup/TitleLogo/LblCompanyName
@onready var save_fail_banner: PanelContainer     = $SaveFailBanner
@onready var save_fail_label:  Label              = $SaveFailBanner/BannerBg/SaveFailLabel
@onready var wip_dialog:       AcceptDialog       = $WipDialog
@onready var overwrite_dialog: ConfirmationDialog = $OverwriteDialog


func _ready() -> void:
    _apply_labels()
    _wire_buttons()
    _refresh_resume_state()
    _refresh_save_banner()
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
    # records.tscn 미구현 — WIP 알림
    _show_wip()


func _on_clock_out() -> void:
    if OS.has_feature("web"):
        # Web 빌드에서는 메뉴 유지 (실제 종료 X)
        return
    get_tree().quit()


func _show_wip() -> void:
    wip_dialog.popup_centered()
