# TODO — 「퇴근 승인 바랍니다」 후속 작업

> 진행 상태 기준일: 2026-05-12
> 우선순위 표기: **P0** 다음 작업 / **P1** 중기 / **P2** 빌드·QA / **P3** 백로그

---

## ✅ Done

- GDD 1~16장 전체 정리 (`gdd.md`)
- 비주얼 정책 — style-guide.md / asset-manifest.md / ui-layout.md
- `project.godot`, autoload 3종 (GameConfig / MessagesDB / GameState)
- Pretendard 폰트 import
- **main_menu.tscn 완성** — 자산 8개(`ui_title_bg / ui_title_logo / ui_title_ceo_mascot / ui_btn_default / ui_savefail_banner`) + 씬 + 스크립트
- 사장 마스코트 누끼(removeBackground) 처리 — RGBA

---

## 🔜 P0 — 다음 우선순위

### 공통 컴포넌트 (다수 퍼즐 의존)
- [ ] `NumPadInput.tscn` + `.gd` — 퍼즐 1·5·8 공용 4자리 키패드 (GDD §9.2)
- [ ] `ClockHUD.tscn` + `.gd` — 헤더 시계 09:00→18:00 + 분침 변경 펄스 (GDD §10.1)
- [ ] `InventoryHUD.tscn` + `.gd` — 아이템 슬롯·사용 (Control anchor)
- [ ] `DialogManager.gd` autoload — 시스템 메시지·선택지 공용 팝업
- [x] ~~`SceneManager.gd` autoload~~ — `change_scene` 래퍼 + `consume_time(scene_change)` + `_notification` 일시정지 핸들러 + Web `quit_or_main` 분기

### 인사 평가 기록 화면 (작업 가벼움)
- [ ] `records.tscn` 자산 3개 생성 (`ui_records_bg`, `ui_records_card_template`, `ui_btn_back`)
- [ ] `records.tscn` + `.gd` — 2×3 카드 그리드, GameState.endings_unlocked 바인딩
- [ ] main_menu → records 전환 활성화 (현재 WIP 알림)

---

## 🚧 P1 — 중기 (사무실부터 단계적)

### office.tscn 1단계: 씬 직접 배치 16개
- [ ] 배경 + 가구·소품 자산 (책상·서랍·포스트잇·의자·화분·벽시계·쓰레기통·사원증·명함·대표포스터·문 4개·컴퓨터)
- [ ] `office.tscn` 씬 트리 + Sprite2D/Area2D 배치
- [ ] 분위기 소품 풍자 팝업 (의자/화분/쓰레기통/사원증/명함/벽시계)
- [ ] 문 4개 씬 이동 (`obj_door_meeting/copy/break/exit_door`) — 대상 씬은 P1 후반 또는 placeholder

### office.tscn 2단계: PC 데스크탑 모달 8개
- [ ] `pc_desktop_bg` + 7개 앱 아이콘 (`pc_icon_clock/mail/share/excel/approval/logout/messenger`)
- [ ] `PcDesktop.tscn` 모달 컴포넌트 — 아이콘 클릭 → 앱 화면 전환

### office.tscn 3단계: PC 앱 화면 + 퍼즐 6종
- [ ] 퍼즐 1: 출근 기록 (`pc_screen_clock` + NumPadInput)
- [ ] 퍼즐 2: 메일 정리 (`pc_screen_mail`)
- [ ] 퍼즐 4: 상사 지시 (`pc_screen_share` + 메일 히스토리 + 화이트보드 단서)
- [ ] 퍼즐 5: 엑셀 매출 (`pc_screen_excel` + NumPadInput + 숨김 시트)
- [ ] 퍼즐 7: 결재 라인 (`pc_screen_approval` + 드래그 연결 + 사장 아바타)
- [ ] 퍼즐 9: 퇴근 시스템 (`pc_screen_logout` + CheckBox + `[loop=false 변경]` 명령 버튼)

### 외부 씬 5개 + 퍼즐 4종
- [ ] `meeting_room.tscn` (5 자산) + 퍼즐 3 회의 일정
- [ ] `copy_room.tscn` (11 자산) + 퍼즐 6 복사기 5단계
- [ ] `break_room.tscn` (10 자산) + 퍼즐 8 탕비실 암호 + 카드키
- [ ] 퍼즐 10 야근 회피 (사무실 출구 + 팀장 NPC 대화)
- [ ] `hidden_staircase.tscn` (5 자산) + 3개 엔딩 트리거

### 엔딩 6종
- [ ] `endings/ending_perfect.tscn`
- [ ] `endings/ending_normal.tscn`
- [ ] `endings/ending_overtime.tscn`
- [ ] `endings/ending_kaltte.tscn`
- [ ] `endings/ending_resign.tscn`
- [ ] `endings/ending_drone.tscn`
- [ ] 엔딩 트리거 시 `GameState.unlock_ending()` 호출 + autosave

---

## 🛠 P2 — 빌드 / 배포 / QA

### Export presets
- [ ] `export_presets.cfg` Web (HTML5, PWA, `canvas_resize_policy`)
- [ ] `export_presets.cfg` Desktop (Win/Mac/Linux 단일 또는 분리)
- [ ] `export_presets.cfg` Android (`gradle_build=true`, landscape, 가로 고정)

### 빌드 검증
- [ ] Web 빌드 — Chrome / Safari 두 브라우저 테스트
- [ ] Desktop 빌드 — macOS / (Win·Linux는 가능하면)
- [ ] Android 빌드 — APK + 실기 1대 이상 테스트
- [ ] 빌드별 자동 일시정지(Android `NOTIFICATION_APPLICATION_PAUSED`, Web `visibilitychange`) 동작
- [ ] 저장 동작 (`user://save.json` → IndexedDB / 파일시스템 / 앱 전용 저장소)

### Android 자산
- [ ] 앱 아이콘 (mdpi 48 / hdpi 72 / xhdpi 96 / xxhdpi 144 / xxxhdpi 192)
- [ ] 스플래시 (선택)

### QA pass (qa-reviewer 에이전트 실행)
- [ ] 빌드 타겟 호환성 체크리스트 (style-guide §6 + qa-reviewer 정의)
- [ ] 자산 매니페스트 ↔ 씬 트리 교차 검증
- [ ] 퍼즐 의존 그래프 — 클리어 불가 상태 없음 확인
- [ ] 텍스트 톤 일관성 (코퍼릿 사족, 호칭 "사원님")
- [ ] 자유 텍스트 입력·호버 의존·사운드 단서 없음 재확인

---

## 🎵 사운드 (별도 트랙)

> 사용자 보류 — 메인 메뉴 BGM은 후속 작업으로 약속됨

- [ ] BGM 메인 메뉴 (잔잔한 코퍼릿 라운지 톤)
- [ ] BGM 사무실 (긴장 + 일상)
- [ ] BGM 히든 루트 (회피·해방감)
- [ ] BGM 엔딩별 6종 (또는 정상 / 야근 / 히든 3종)
- [ ] SFX: 클릭 / 호버(데스크탑만) / 정답 / 오답 / 시간 감소 / 씬 전환 / 인벤토리 획득
- [ ] AudioManager autoload — 카테고리별 버스, Web 첫 입력 후 재생 가드, 일시정지 동기화

---

## 📝 GDD 보강 (사용자가 미뤄둔 항목)

- [ ] 사운드 기획 절 (BGM 톤, SFX 카탈로그, 큐 시스템)
- [ ] 튜토리얼/온보딩 (첫 진입 시 조작 가이드 흐름)
- [x] ~~엔딩 분기 락인 시점~~ — GDD §6.1/§6.2 추가 완료
- [x] ~~퍼즐 의존 그래프~~ — GDD §4.11/§4.12 추가 완료
- [ ] 로컬라이제이션 정책 (한국어 전용? 다국어?)
- [ ] 접근성 (색약 배려, 키보드 only navigation, 폰트 크기 옵션)

---

## 🎨 디테일 자산 / 미세 조정 (P3)

- [x] ~~사장 마스코트 표정 셋: `disappointed` / `proud`~~ — editImage로 파생 (`ceo_mascot_disappointed_v1` / `ceo_mascot_proud_v1`) + idle 호흡 animateSprite 시트(`ceo_mascot_idle_anim_v1`, 16프레임 2048×2048)
- [ ] 사장 캐릭터 다른 자산 파생: `obj_ceo_poster` 흉상 + `npc_avatar_ceo` 256×256 원형 아바타
- [ ] 팀장(`npc_team_lead`) 캐릭터 명세 + 자산 (퍼즐 10)
- [ ] 메일·메신저 발신자 아바타 (작은 원형)
- [ ] 인벤토리 아이콘 5종 (`item_card_key` 등)
- [ ] `ui_savefail_banner` 양쪽 swallowtail 단순화 (현재 매니페스트 OK 처리됐으나 옵션)
- [x] ~~메인 메뉴 진입 애니메이션~~ — Logo 0.3s 페이드 + Mascot 0.4s 페이드·슬라이드 + Buttons 순차 페이드 + Mascot 호흡 무한 루프

---

## 🤔 결정 필요 (Decisions)

- [ ] Desktop 빌드 OS 분리 여부 (단일 vs Win/Mac/Linux 각각)
- [ ] 로컬라이제이션 도입 여부 (`MessagesDB`는 i18n 가능 구조 이미 갖춤)
- [ ] 사장 캐릭터 다른 자산을 같은 시트에서 파생할 방법 (`editImage` vs 새 `createImage`)
- [ ] BGM 톤 키워드 (장르: lo-fi corporate / minimal piano / ambient / chiptune…)
- [ ] 엔딩 트리거 후 records 화면으로 자동 이동할지, 메인 메뉴로 갈지

---

## 🔗 의존 관계 (요약)

```
공통 컴포넌트(NumPadInput, ClockHUD, InventoryHUD, DialogManager, SceneManager)
    │
    ├─ records.tscn         ← 빠르게 빠짐
    ├─ office.tscn          ← 3단계
    │     ├─ 1) 씬 직접 16개
    │     ├─ 2) PC 데스크탑 + 8개 아이콘
    │     └─ 3) PC 앱 화면 7개 + 퍼즐 6종
    ├─ meeting/copy/break_room
    ├─ hidden_staircase + 카드키
    └─ endings 6종

빌드/QA는 위 모든 게 끝난 뒤 P2
사운드는 모든 단계에 평행 트랙
```
