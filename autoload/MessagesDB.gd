extends Node

const MSG := {
    # 메인 메뉴
    &"menu_title_subtitle":   "{GAME_TITLE}",
    &"menu_btn_clock_in":     "출근하기",
    &"menu_btn_resume":       "업무 복귀",
    &"menu_btn_records":      "인사 평가 기록",
    &"menu_btn_clock_out":    "퇴근하기",
    &"menu_btn_clock_out_web": "메인으로",

    # 저장 차단 배너
    &"save_blocked_banner":   "※ 사내 시스템 접근이 차단되어 있습니다. 세션 동안만 진행이 유지됩니다.",

    # 다이얼로그
    &"dialog_overwrite_save_title": "[ 사내 알림 ]",
    &"dialog_overwrite_save_body":  "기존 진행 기록이 존재합니다.\n새 게임을 시작하면 기존 기록은 덮어쓰기 처리됩니다.\n계속 진행하시겠습니까?",
    &"dialog_ok":                   "진행",
    &"dialog_cancel":               "취소",

    # 미구현 (placeholder)
    &"dialog_wip_title":            "[ 사내 알림 ]",
    &"dialog_wip_body":             "해당 기능은 아직 준비 중입니다.\n검토 후 회신드리겠습니다.\n양해 부탁드립니다.",
}

func get_text(key: StringName) -> String:
    if not MSG.has(key):
        return "[missing: %s]" % key
    return GameConfig.resolve(MSG[key])
