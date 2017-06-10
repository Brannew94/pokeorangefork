_OptionsMenu: ; e41d0
	ld hl, hInMenu
	ld a, [hl]
	push af
	ld [hl], $1
	call ClearBGPalettes
	hlcoord 0, 0
	ld b, 16
	ld c, 18
	call TextBox
	hlcoord 2, 2
	ld de, StringOptions
	call PlaceString
	xor a
	ld [wJumptableIndex], a
	ld c, $6 ; number of items on the menu minus 1 (for Done)

.print_text_loop ; this next will display the settings of each option when the menu is opened
	push bc
	xor a
	ld [hJoyLast], a
	call GetOptionPointer
	pop bc
	ld hl, wJumptableIndex
	inc [hl]
	dec c
	jr nz, .print_text_loop

	call UpdateFrame
	xor a
	ld [wJumptableIndex], a
	inc a
	ld [hBGMapMode], a
	call WaitBGMap
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	call SetPalettes

.joypad_loop
	call JoyTextDelay
	ld a, [hJoyPressed]
	and START | B_BUTTON
	jr nz, .ExitOptions
	call OptionsControl
	jr c, .dpad
	call GetOptionPointer
	jr c, .ExitOptions

.dpad
	call Options_UpdateCursorPosition
	ld c, 3
	call DelayFrames
	jr .joypad_loop

.ExitOptions:
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	pop af
	ld [hInMenu], a
	ret
; e4241

StringOptions: ; e4241
	db "TEXT SPEED<LNBRK>"
	db "        :<LNBRK>"
	db "BATTLE SCENE<LNBRK>"
	db "        :<LNBRK>"
	db "BATTLE STYLE<LNBRK>"
	db "        :<LNBRK>"
	db "SOUND<LNBRK>"
	db "        :<LNBRK>"
	db "MENU ACCOUNT<LNBRK>"
	db "        :<LNBRK>"
	db "FRAME<LNBRK>"
	db "        :TYPE<LNBRK>"
	db "<LNBRK>"
	db "<LNBRK>"
	db "DONE@"
; e42d6


GetOptionPointer: ; e42d6
	ld a, [wJumptableIndex] ; load the cursor position to a
	ld e, a ; copy it to de
	ld d, 0
	ld hl, .Pointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl ; jump to the code of the current highlighted item
; e42e5

.Pointers:
	dw Options_TextSpeed
	dw Options_BattleScene
	dw Options_BattleStyle
	dw Options_Sound
	dw Options_MenuAccount
	dw Options_Frame
	dw Options_Unused
	dw Options_Done
; e42f5


Options_TextSpeed: ; e42f5
	call GetTextSpeed
	ld a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	ld a, c ; right pressed
	cp SLOW_TEXT
	jr c, .Increase
	ld c, FAST_TEXT +- 1

.Increase:
	inc c
	ld a, e
	jr .Save

.LeftPressed:
	ld a, c
	and a
	jr nz, .Decrease
	ld c, SLOW_TEXT + 1

.Decrease:
	dec c
	ld a, d

.Save:
	ld b, a
	ld a, [Options]
	and $f0
	or b
	ld [Options], a

.NonePressed:
	ld b, 0
	ld hl, .Strings
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 11, 3
	call PlaceString
	and a
	ret
; e4331

.Strings:
	dw .Fast
	dw .Mid
	dw .Slow

.Fast:
	db "FAST@"
.Mid:
	db "MID @"
.Slow:
	db "SLOW@"
; e4346


GetTextSpeed: ; e4346
	ld a, [Options] ; This converts the number of frames, to 0, 1, 2 representing speed
	and 7
	cp 5 ; 5 frames of delay is slow
	jr z, .slow
	cp 1 ; 1 frame of delay is fast
	jr z, .fast
	ld c, MED_TEXT ; set it to mid if not one of the above
	lb de, 1, 5
	ret

.slow
	ld c, SLOW_TEXT
	lb de, 3, 1
	ret

.fast
	ld c, FAST_TEXT
	lb de, 5, 3
	ret
; e4365


Options_BattleScene: ; e4365
	ld hl, Options
	ld a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit BATTLE_SCENE, [hl]
	jr nz, .ToggleOn
.ToggleOff:
	set BATTLE_SCENE, [hl]
	ld de, .Off
.Display:
	hlcoord 11, 5
	call PlaceString
	and a
	ret
; e4398

.LeftPressed:
	bit BATTLE_SCENE, [hl]
	jr z, .ToggleOff
.ToggleOn:
	res BATTLE_SCENE, [hl]
	ld de, .On
	jr .Display

.NonePressed:
	bit BATTLE_SCENE, [hl]
	jr z, .ToggleOn
	jr .ToggleOff

.On:
	db "ON @"
.Off:
	db "OFF@"
; e43a0


Options_BattleStyle: ; e43a0
	ld hl, Options
	ld a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit BATTLE_SHIFT, [hl]
	jr nz, .ToggleShift
.ToggleSet:
	set BATTLE_SHIFT, [hl]
	ld de, .Set
.Display:
	hlcoord 11, 7
	call PlaceString
	and a
	ret
; e43d1

.LeftPressed:
	bit BATTLE_SHIFT, [hl]
	jr z, .ToggleSet
.ToggleShift:
	res BATTLE_SHIFT, [hl]
	ld de, .Shift
	jr .Display

.NonePressed:
	bit BATTLE_SHIFT, [hl]
	jr nz, .ToggleSet
	jr .ToggleShift

.Shift:
	db "SHIFT@"
.Set:
	db "SET  @"
; e43dd


Options_Sound: ; e43dd
	ld hl, Options
	ld a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit STEREO, [hl]
	jr nz, .SetMono
.SetStereo:
	set STEREO, [hl]
	call RestartMapMusic
.ToggleStereo:
	ld de, .Stereo
.Display:
	hlcoord 11, 9
	call PlaceString
	and a
	ret
; e4416

.LeftPressed:
	bit STEREO, [hl]
	jr z, .SetStereo
.SetMono:
	res STEREO, [hl]
	call RestartMapMusic
.ToggleMono:
	ld de, .Mono
	jr .Display

.NonePressed:
	bit STEREO, [hl]
	jr nz, .ToggleStereo
	jr .ToggleMono

.Mono:
	db "MONO  @"
.Stereo:
	db "STEREO@"
; e4424


Options_MenuAccount: ; e44c1
	ld hl, Options2
	ld a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	bit MENU_ACCOUNT, [hl]
	jr nz, .ToggleOff
.ToggleOn:
	set MENU_ACCOUNT, [hl]
	ld de, .On
.Display:
	hlcoord 11, 11
	call PlaceString
	and a
	ret
; e44f2

.LeftPressed:
	bit MENU_ACCOUNT, [hl]
	jr z, .ToggleOn
.ToggleOff:
	res MENU_ACCOUNT, [hl]
	ld de, .Off
	jr .Display

.NonePressed:
	bit MENU_ACCOUNT, [hl]
	jr nz, .ToggleOn
	jr .ToggleOff

.Off:
	db "OFF@"
.On:
	db "ON @"
; e44fa


Options_Frame: ; e44fa
	ld hl, TextBoxFrame
	ld a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr nz, .RightPressed
	and a
	ret

.RightPressed:
	ld a, [hl]
	inc a
	cp $9 ; max + 1
	jr nz, .Save
	xor a ; min
	jr .Save

.LeftPressed:
	ld a, [hl]
	dec a
	cp $ff ; min - 1
	jr nz, .Save
	ld a, $8 ; max
.Save:
	ld [hl], a
UpdateFrame: ; e4512
	ld a, [TextBoxFrame]
	hlcoord 16, 13 ; where on the screen the number is drawn
	add "1"
	ld [hl], a
	call LoadFontsExtra
Options_Unused:
	and a
	ret
; e4520


Options_Done: ; e4520
	ld a, [hJoyPressed]
	and A_BUTTON
	jr nz, .Exit
	and a
	ret

.Exit:
	scf
	ret
; e452a


OptionsControl: ; e452a
	ld hl, wJumptableIndex
	ld a, [hJoyLast]
	cp D_DOWN
	jr z, .DownPressed
	cp D_UP
	jr z, .UpPressed
	and a
	ret

.DownPressed:
	ld a, [hl] ; load the cursor position to a
	cp $7 ; last item
	jr z, .WrapTop
	cp $5 ; before unused $6
	jr nz, .noskipdown
	inc [hl]
.noskipdown
	inc [hl]
	scf
	ret

.WrapTop:
	ld [hl], $0 ; first item
	scf
	ret

.UpPressed:
	ld a, [hl] ; load the cursor position to a
	cp $0 ; first item
	jr z, .WrapBottom
	cp $7 ; after unused $6
	jr nz, .noskipup
	dec [hl]
.noskipup
	dec [hl]
	scf
	ret

.WrapBottom:
	ld [hl], $7 ; last item
	scf
	ret
; e455c

Options_UpdateCursorPosition: ; e455c
	hlcoord 1, 1
	ld de, SCREEN_WIDTH
	ld c, $10
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	hlcoord 1, 2
	ld bc, 2 * SCREEN_WIDTH
	ld a, [wJumptableIndex]
	call AddNTimes
	ld [hl], "▶"
	ret
; e4579
