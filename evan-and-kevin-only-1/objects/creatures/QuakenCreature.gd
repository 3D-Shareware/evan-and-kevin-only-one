class_name QuakenCreature extends EarthCreature

func ready_creature():
	display_name = "Quaken"
	sprite_path = load("res://assets/creatures/quaken.png")
	spawn_anim = "Drill"
	base_health = 165
	base_power = 55
	base_speed = 80
	guaranteed_moves = [TremorMove]
	extra_moves = []
