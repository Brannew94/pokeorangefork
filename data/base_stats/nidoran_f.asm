	db NIDORAN_F ; 029

	db  55,  47,  52,  41,  40,  40
	;   hp  atk  def  spd  sat  sdf

	db POISON, POISON
	db 235 ; catch rate
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db ALL_FEMALE ; gender
	db 20 ; step cycles to hatch
	dn 5, 5 ; frontpic dimensions

	db MEDIUM_SLOW ; growth rate
	dn MONSTER, FIELD ; egg groups

	; tmhm
	tmhm WATER_PULSE, VENOSHOCK, TOXIC, SUNNY_DAY, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, SHADOW_CLAW, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, DOUBLE_TEAM, SLUDGE_BOMB, AERIAL_ACE, FACADE, REST, THIEF, CUT, STRENGTH, ROCK_SMASH, HEADBUTT, BODY_SLAM, COUNTER, SUBSTITUTE, ENDURE, SWAGGER, SLEEP_TALK, ATTRACT, POISON_JAB
	; end
