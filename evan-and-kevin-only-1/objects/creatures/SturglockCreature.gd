class_name SturglockCreature extends WaterCreature

func ready_creature():
	display_name = "Sturglock"
	sprite_path = load("res://assets/creatures/sturglock.png")
	spawn_anim = "Magic"
	base_health = 60
	base_power = 110
	base_speed = 130
	guaranteed_moves = [ExtinguishMove, DownpourMove]
	extra_moves = []
