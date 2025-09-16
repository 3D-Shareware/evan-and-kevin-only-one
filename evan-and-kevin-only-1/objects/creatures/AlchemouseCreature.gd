class_name AlchemouseCreature extends PlagueCreature

func ready_creature():
	display_name = "Alchemouse"
	sprite_path = load("res://assets/creatures/alchemouse.png")
	spawn_anim = "Bounce"
	base_health = 75
	base_power = 55
	base_speed = 170
	guaranteed_moves = [DownpourMove]
	extra_moves = []
