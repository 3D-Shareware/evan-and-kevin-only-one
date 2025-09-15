class_name BrinotaurCreature extends WaterCreature

func ready_creature():
	display_name = "Brinotaur"
	sprite_path = load("res://assets/creatures/brinotaur.png")
	spawn_anim = "Heavy"
	base_health = 95
	base_power = 140
	base_speed = 65
	guaranteed_moves = [DownpourMove]
	extra_moves = [TremorMove, TimberMove]
