	db SANDSHREW ; 027

	db  50,  75,  85,  40,  20,  30
	;   hp  atk  def  spd  sat  sdf

	db GROUND, GROUND
	db 255 ; catch rate
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db FEMALE_50 ; gender
	db 20 ; step cycles to hatch
	dn 5, 5 ; frontpic dimensions

	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm TOXIC, FISSURE, SUNNY_DAY, PROTECT, SHADOW_CLAW, IRON_TAIL, EARTHQUAKE, RETURN, DIG, DOUBLE_TEAM, EARTH_POWER, SANDSTORM, AERIAL_ACE, FACADE, REST, THIEF, ROCK_SLIDE, CUT, STRENGTH, ROCK_SMASH, ROCK_CLIMB, DYNAMICPUNCH, HEADBUTT, POISON_JAB, SLEEP_TALK, SUBSTITUTE, BODY_SLAM, ATTRACT, SWAGGER, ENDURE
	; end
