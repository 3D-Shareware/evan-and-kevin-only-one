class_name BrinotaurCreature extends WaterCreature

func ready_creature():
	display_name = "Brinotaur"
	sprite_path = load("res://assets/creatures/brinotaur.png")
	spawn_anim = "Heavy"
	descr = "Old, sea-salted pirate that’s barely anchored to this plane of existence. Constantly plundering and pillaging. According to legend, a Brinotaur takes every treasure it finds to the afterlife."
	base_health = 95
	base_power = 140
	base_speed = 65
	guaranteed_moves = [DownpourMove, CrashingWaveMove, AnchorSlamMove, PlunderMove]
	extra_moves = [HydroBurstMove, TremorMove, TimberMove, SniffOutMove, HealingWaterMove]
