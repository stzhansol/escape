extends Node

const COMPANY_NAME       := "애니 주식회사"
const COMPANY_NAME_SHORT := "애니㈜"
const GAME_TITLE         := "퇴근 승인 바랍니다"

const CEO_NAME           := "핑크 토끼"
const CEO_TITLE          := "대표이사"

const DEPT_SALES_1       := "영업1팀"
const DEPT_HR            := "인사팀"
const DEPT_IT            := "IT팀"
const ROLE_TEAM_LEAD     := "팀장"
const ROLE_MANAGER       := "부장"

const _TOKENS := [
    "COMPANY_NAME", "COMPANY_NAME_SHORT", "GAME_TITLE",
    "CEO_NAME", "CEO_TITLE",
    "DEPT_SALES_1", "DEPT_HR", "DEPT_IT",
    "ROLE_TEAM_LEAD", "ROLE_MANAGER",
]

func resolve(text: String) -> String:
    var out := text
    for key in _TOKENS:
        out = out.replace("{%s}" % key, str(get(key)))
    return out
