# Asset Manifest

> 모든 좌표는 base 1920×1080 픽셀 (`style-guide.md` §1 참조).
> Status: `PENDING` (미생성) / `OK` (생성·검증 완료) / `FAILED` (생성 실패, godot-developer는 placeholder 사용 금지)

---

## main_menu.tscn (8개)

```yaml
- id: ui_title_bg
  type: background
  scene: main_menu
  file: res://assets/main_menu/ui_title_bg.png
  prompt: |
    [SUBJECT] a calm, cozy office-style title screen background,
      a soft empty workspace at gentle morning light,
      faint hints of cream walls and warm pastel pink accents,
      no characters, no text, no furniture details up close,
      composition with empty negative space in the upper-left area
      (for logo) and right area (for character)
    [COMPOSITION] wide 16:9, gentle vignette to center,
      soft empty layout, no foreground objects, viewing slightly tilted up
    [STYLE/LIGHTING/TECH/NEGATIVE] from style-guide.md §2
  size: { w: 1920, h: 1080 }
  position: { x: 0, y: 0 }
  anchor: top_left
  z_index: 0
  status: OK
  generated_url: https://storage.googleapis.com/ludo-assets/api/eb9d17b5216fa5eebe4278ac293a7087.webp
  local_file: res://assets/main_menu/ui_title_bg.png
  request_id: title_bg_v2
  used_by: [main_menu]

- id: ui_title_logo
  type: ui
  scene: main_menu
  file: res://assets/main_menu/ui_title_logo.png
  prompt: |
    [SUBJECT] a minimal company emblem mark for a fictional corporation,
      cute corporate vibe, simple geometric shape (rounded rectangle frame),
      soft baby pink #FFB7C9 fill, LINELESS (no outline),
      subtle inner darker pink #E89BB0 shade for depth, soft drop shadow underneath,
      empty inside (company name will be overlaid by Godot Label),
      NO TEXT in image
    [COMPOSITION] centered emblem, transparent background, square framing
    [STYLE/LIGHTING/TECH/NEGATIVE] from style-guide.md §2 (lineless 기조)
  size: { w: 480, h: 260 }
  position: { x: 80, y: 80 }
  anchor: top_left
  z_index: 2
  status: OK
  generated_url: https://storage.googleapis.com/ludo-assets/api/17b342ed3244b5a61f9c2f6cd26e21a1.webp
  local_file: res://assets/main_menu/ui_title_logo.png
  request_id: ui_title_logo_v3
  notes: 좌측에 토끼 귀 실루엣 마크 + 우측 비어있어 회사명 Label 오버레이. v1(hex 텍스트 버그)·v2(빈 프레임)는 archive/ 보존
  used_by: [main_menu]

- id: ui_title_ceo_mascot
  type: character
  scene: main_menu
  file: res://assets/main_menu/ui_title_ceo_mascot.png
  prompt: |
    [SUBJECT] {style-guide.md §4 캐릭터 템플릿 그대로},
      full body standing pose, idle expression (gentle calm smile),
      both hands folded politely in front of chest,
      slight idle breathing posture, looking forward
    [COMPOSITION] full body portrait, centered, transparent background,
      portrait framing 4:6 (taller than wide), no shadow under feet
    [STYLE/LIGHTING/TECH/NEGATIVE] from style-guide.md §2
  size: { w: 640, h: 960 }
  position: { x: 1200, y: 60 }
  anchor: top_left
  z_index: 3
  status: OK
  generated_url: https://storage.googleapis.com/ludo-assets/api/7723104f80545c999a4476b65ffbbd1a.webp
  bg_removed_url: https://storage.googleapis.com/ludo-assets/api/48d56b59406c73028f2f73601b81bf86.webp
  local_file: res://assets/main_menu/ui_title_ceo_mascot.png
  request_id: ceo_mascot_v2
  expression_set:
    - id: ui_title_ceo_mascot_disappointed
      file: res://assets/main_menu/ui_title_ceo_mascot_disappointed.png
      url: https://storage.googleapis.com/ludo-assets/api/0a8449fb917d3146ae48148819f43baa.webp
      request_id: ceo_mascot_disappointed_v1
      use_cases: [puzzle_failed, ending_overtime]
    - id: ui_title_ceo_mascot_proud
      file: res://assets/main_menu/ui_title_ceo_mascot_proud.png
      url: https://storage.googleapis.com/ludo-assets/api/3462ae2ae2b01169cb8bfc580ffa19da.webp
      request_id: ceo_mascot_proud_v1
      use_cases: [puzzle_solved, ending_perfect, praise_dialog]
  animation_set:
    - id: ui_title_ceo_mascot_idle_sheet
      file: res://assets/main_menu/ui_title_ceo_mascot_idle_sheet.png
      url: https://storage.googleapis.com/ludo-assets/api/2cde226d42add5a8bec6cdbb4ba53058.webp
      preview_video: https://storage.googleapis.com/ludo-assets/api/6a75a1f2c598aad54bd5befdb1be2b0e.mp4
      request_id: ceo_mascot_idle_anim_v1
      motion: idle breathing + eyes blink once
      frames: 16
      frame_size: 512                          # 시트 2048×2048 ÷ 4×4
      duration_seconds: 1.67
      loop: true
      use_cases: [main_menu]
  notes: lineless 톤 채택본 + 누끼 RGBA + 표정 셋 disappointed/proud editImage 파생 + idle 호흡 animateSprite 시트. v1/v3/v4는 archive/.
  used_by: [main_menu]

- id: ui_btn_clock_in
  type: ui
  scene: main_menu
  file: res://assets/main_menu/ui_btn_clock_in.png
  prompt: |
    [SUBJECT] a cute rounded rectangle button frame,
      bunny pink #FFB7C9 filled background, LINELESS (no outline at all),
      shape separation only by very subtle soft drop shadow underneath
      and slightly darker pink #E89BB0 inner bottom edge gradient,
      empty center (text will be overlaid by Godot Label),
      NO TEXT in image
    [COMPOSITION] horizontal pill shape, transparent background,
      no decorations beside frame
    [STYLE/LIGHTING/TECH/NEGATIVE] from style-guide.md §2 (lineless 기조)
  size: { w: 580, h: 128 }
  position: { x: 670, y: 220 }
  anchor: top_left
  z_index: 4
  hitbox: { x: 662, y: 212, w: 596, h: 144 }
  shared_texture: ui_btn_default   # 4개 버튼이 같은 파일을 공유
  pressed_via: modulate (scale 0.97, color 0.95)   # 별도 자산 없음
  disabled_via: modulate alpha 0.45                # 별도 자산 없음
  status: OK
  generated_url: https://storage.googleapis.com/ludo-assets/api/b766e2b4fe94013d9c9d595d9c89f3ae.webp
  local_file: res://assets/main_menu/ui_btn_default.png
  request_id: ui_btn_default_v2
  notes: 4개 버튼 모두 단일 ui_btn_default.png 공유. v1은 hex 텍스트 박혀 폐기, archive/ 보존
  used_by: [main_menu]

- id: ui_btn_resume
  type: ui
  scene: main_menu
  file: res://assets/main_menu/ui_btn_default.png
  shared_texture: ui_btn_default
  size: { w: 580, h: 128 }
  position: { x: 670, y: 380 }
  anchor: top_left
  z_index: 4
  hitbox: { x: 662, y: 372, w: 596, h: 144 }
  disabled_via: modulate alpha 0.45
  status: OK
  used_by: [main_menu]

- id: ui_btn_records
  type: ui
  scene: main_menu
  file: res://assets/main_menu/ui_btn_default.png
  shared_texture: ui_btn_default
  size: { w: 580, h: 128 }
  position: { x: 670, y: 540 }
  anchor: top_left
  z_index: 4
  hitbox: { x: 662, y: 532, w: 596, h: 144 }
  status: OK
  used_by: [main_menu]

- id: ui_btn_clock_out
  type: ui
  scene: main_menu
  file: res://assets/main_menu/ui_btn_default.png
  shared_texture: ui_btn_default
  size: { w: 580, h: 128 }
  position: { x: 670, y: 700 }
  anchor: top_left
  z_index: 4
  hitbox: { x: 662, y: 692, w: 596, h: 144 }
  status: OK
  used_by: [main_menu]

- id: ui_savefail_banner
  type: ui
  scene: main_menu
  file: res://assets/main_menu/ui_savefail_banner.png
  prompt: |
    [SUBJECT] a thin horizontal banner ribbon,
      honey yellow #F4C95D filled background, LINELESS (no outline),
      shape separation only by very subtle soft drop shadow underneath,
      empty center (warning text will be overlaid),
      no icons, NO TEXT in image
    [COMPOSITION] very wide thin ribbon, transparent background
    [STYLE/LIGHTING/TECH/NEGATIVE] from style-guide.md §2 (lineless 기조)
  size: { w: 1792, h: 56 }
  position: { x: 64, y: 960 }
  anchor: top_left
  z_index: 5
  status: OK
  generated_url: https://storage.googleapis.com/ludo-assets/api/f98545102a28b7e92ca9bfb56cc80acd.webp
  local_file: res://assets/main_menu/ui_savefail_banner.png
  request_id: ui_savefail_banner_v2
  notes: ribbon swallowtail 양쪽 꼬리 + 옅은 광택이 들어가 있음. negative에 명시했지만 결과 유지. v1은 hex 텍스트 박혀 폐기, archive/ 보존
  used_by: [main_menu]
```

---

## records.tscn (3개, ui_btn_back은 ui_btn_default 공유)

```yaml
- id: ui_records_bg
  type: background
  scene: records
  file: res://assets/records/ui_records_bg.png
  prompt: |
    [SUBJECT] HR records review screen background, cream white base
      with very subtle warm pastel pink accents in corners,
      header strip at top, empty center for 2x3 card grid
    [COMPOSITION] wide 16:9, empty center for cards,
      narrow top header band, soft framing only at edges
    [STYLE/LIGHTING/TECH/NEGATIVE] from style-guide.md §2 (lineless 기조)
  size: { w: 1920, h: 1080 }
  position: { x: 0, y: 0 }
  anchor: top_left
  z_index: 0
  status: OK
  generated_url: https://storage.googleapis.com/ludo-assets/api/ca2a4783dca94aba48c614f89dfb5a2e.webp
  local_file: res://assets/records/ui_records_bg.png
  request_id: ui_records_bg_v1
  used_by: [records]

- id: ui_records_card_template
  type: ui
  scene: records
  file: res://assets/records/ui_records_card_template.png
  prompt: |
    [SUBJECT] empty rounded rectangle card frame, cream white fill,
      small soft pink corner tab in upper-left (decorative tape look),
      slightly darker cream bottom edge, subtle drop shadow,
      no text, no icons inside
    [COMPOSITION] only the card centered, transparent background
    [STYLE/LIGHTING/TECH/NEGATIVE] from style-guide.md §2 (lineless 기조)
  size: { w: 580, h: 240 }                     # 6번 인스턴스화하여 2×3 그리드 구성
  anchor: top_left
  z_index: 2
  hitbox: { x: 0, y: 0, w: 580, h: 240 }       # 각 인스턴스마다 position 다름 (records.tscn 참조)
  status: OK
  generated_url: https://storage.googleapis.com/ludo-assets/api/235b1743ffcf68f8357b3f9e4672846d.webp
  local_file: res://assets/records/ui_records_card_template.png
  request_id: ui_records_card_template_v1
  used_by: [records]

- id: ui_btn_back
  type: ui
  scene: records
  file: res://assets/main_menu/ui_btn_default.png    # ui_btn_default 공유 (main_menu와 동일 자산)
  shared_texture: ui_btn_default
  size: { w: 280, h: 80 }                            # 작게 사용 (TextureRect 스케일 다름)
  position: { x: 1560, y: 40 }                       # 우상단 헤더
  anchor: top_left
  z_index: 3
  hitbox: { x: 1552, y: 32, w: 296, h: 96 }
  status: OK
  used_by: [records]
```

---

> 다른 씬(office 등) 자산은 후속 합의 시 추가.
