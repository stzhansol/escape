---
name: escape-room-orchestrator
description: "방탈출 싱글플레이어 게임 개발 전체 워크플로우를 조율하는 오케스트레이터. 기획부터 Godot 구현까지 game-designer, godot-developer, ui-ux-designer, qa-reviewer 팀을 운영. '방탈출 게임 만들어줘', '게임 전체 기획해줘', '처음부터 만들어줘', '게임 개발 시작', '다시 만들어줘', '이전 결과 수정', '재실행' 요청 시 반드시 이 스킬을 사용할 것."
---

# Escape Room Orchestrator

방탈출 게임 개발 팀을 조율한다. 기획(GDD) → 설계(씬+UI) → 구현(Godot) → 검증(QA) 파이프라인을 에이전트 팀으로 실행.

**실행 모드:** 에이전트 팀 (파이프라인 패턴)

## Phase 0: 컨텍스트 확인

`_workspace/` 존재 여부로 실행 모드 결정:

- `_workspace/gdd.md` 없음 → **초기 실행** (Phase 1부터)
- `_workspace/` 있고 사용자가 부분 수정 요청 → **부분 재실행** (해당 Phase만)
- `_workspace/` 있고 새 컨셉 제공 → **새 실행** (기존을 `_workspace_prev/`로 이동)

## Phase 1: GDD 작성 (game-designer)

**실행 모드:** 서브 에이전트 (단독 작업)

game-designer를 서브 에이전트로 호출:
- 입력: 사용자의 게임 컨셉/테마
- 작업: GDD 작성 → `_workspace/gdd.md` 저장
- 작업: 퍼즐 맵 작성 → `_workspace/puzzle-map.md` 저장
- gdd-writer 스킬 참조

GDD 완성 후 Phase 2로 이동.

## Phase 2: 씬 구조 + UI 설계 (팀)

**실행 모드:** 에이전트 팀

TeamCreate로 3명 팀 구성:
- game-designer: `_workspace/gdd.md` 읽고 씬 분해 (방별 오브젝트 목록)
- godot-developer: 씬 노드 구조 명세 → `_workspace/scene-structure.md`
- ui-ux-designer: UI 레이아웃 설계 → `_workspace/ui-layout.md`

팀원들은 SendMessage로 직접 소통:
- game-designer → godot-developer: 구현 불가한 요소 피드백 요청
- game-designer → ui-ux-designer: 각 방의 UI 요구사항 전달
- godot-developer ↔ ui-ux-designer: Control 노드 구조 협의

모든 TeamUpdate 완료 후 팀 해체, Phase 3으로.

## Phase 3: Godot 구현 (godot-developer + ui-ux-designer)

**실행 모드:** 에이전트 팀

TeamCreate로 2명 팀 구성:
- godot-developer: 씬별 GDScript 구현 (퍼즐 로직, 인벤토리, 씬 전환, 저장)
- ui-ux-designer: UI 씬 GDScript 구현 지원

구현 산출물: 복사 가능한 GDScript 코드 블록 + 씬 구조 설명
파일 저장: `_workspace/impl-{scene_name}.md` 형식

## Phase 4: QA 검증 (qa-reviewer)

**실행 모드:** 서브 에이전트 (독립 검증)

qa-reviewer를 서브 에이전트로 호출:
- `_workspace/` 전체 읽기
- Critical 이슈 발견 시: 해당 Phase 재실행
- `_workspace/qa-report.md` 저장

## Phase 5: 산출물 최종화

사용자에게 전달:
1. `_workspace/gdd.md` — 게임 기획서
2. `_workspace/scene-structure.md` — Godot 씬 구조
3. `_workspace/ui-layout.md` — UI 레이아웃
4. `_workspace/impl-*.md` — 구현 코드
5. `_workspace/qa-report.md` — QA 보고서

## 에러 핸들링

- 에이전트 실패 시: 1회 재시도, 재실패 시 해당 결과 없이 진행 (보고서에 누락 명시)
- Critical QA 이슈: 해당 Phase만 재실행 (최대 2회)
- 컨셉 불분명 시: game-designer가 3가지 테마 제안

## 데이터 흐름

```
사용자 컨셉
    ↓
[game-designer] → gdd.md, puzzle-map.md
    ↓
[팀: game-designer + godot-developer + ui-ux-designer]
    → scene-structure.md, ui-layout.md
    ↓
[팀: godot-developer + ui-ux-designer]
    → impl-*.md
    ↓
[qa-reviewer] → qa-report.md
    ↓
최종 산출물 사용자 전달
```

## 테스트 시나리오

**정상 흐름:**
- 입력: "연구실 테마 방탈출 게임. 방 2개. 과학 퍼즐 포함."
- 기대: gdd.md (방 2개, 퍼즐 3~5개), scene-structure.md, ui-layout.md, 구현 코드

**에러 흐름:**
- 입력: 테마 없이 "방탈출 게임 만들어줘"
- 기대: game-designer가 3가지 테마 제안 (예: 연구실/고택/우주선) 후 사용자 선택 대기
