	db HO_OH ; 250

	db 106, 130,  90,  90, 110, 154
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FLYING
	db 3 ; catch rate
	db SACRED_ASH ; item 1
	db SACRED_ASH ; item 2
	db GENDERLESS ; gender
	db 120 ; step cycles to hatch
	dn 7 , 7 ; frontpic dimensions

	db SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; tmhm
	tmhm TOXIC, SUNNY_DAY, HYPER_BEAM, DRAGONBREATH, PROTECT, RAIN_DANCE, GIGA_DRAIN, SOLARBEAM, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, PSYCHIC_M, SHADOW_BALL, DOUBLE_TEAM, EARTH_POWER, GIGA_IMPACT, FLAMETHROWER, SANDSTORM, FIRE_BLAST, AERIAL_ACE, FACADE, REST, STEEL_WING, FLASH, FLY, STRENGTH, ROCK_SMASH, ZEN_HEADBUTT, SLEEP_TALK, SUBSTITUTE, SWAGGER, ENDURE, SIGNAL_BEAM
	; end
