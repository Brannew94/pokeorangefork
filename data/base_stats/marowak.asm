	db MAROWAK ; 105

	db  60,  80, 110,  45,  50,  80
	;   hp  atk  def  spd  sat  sdf

	db FIRE, GHOST
	db 75 ; catch rate
	db NO_ITEM ; item 1
	db THICK_CLUB ; item 2
	db FEMALE_50 ; gender
	db 20 ; step cycles to hatch
	dn 6, 6 ; frontpic dimensions

	db MEDIUM_FAST ; growth rate
	dn MONSTER, MONSTER ; egg groups

	; tmhm
	tmhm DARK_PULSE, TOXIC, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, SHADOW_BALL, DOUBLE_TEAM, EARTH_POWER, GIGA_IMPACT, FLAMETHROWER, SANDSTORM, FIRE_BLAST, AERIAL_ACE, FACADE, REST, THIEF, ROCK_SLIDE, SLEEP_TALK, SUBSTITUTE, ATTRACT, SWAGGER
	; end
