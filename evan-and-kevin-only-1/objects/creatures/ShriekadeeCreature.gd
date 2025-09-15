class_name ShriekadeeCreature extends PlantCreature

func ready_creature():
	display_name = "Shriekadee"
	sprite_path = load("res://assets/creatures/shriekadee.png")
	spawn_anim = "Rise"
	base_health = 45
	base_power = 115
	base_speed = 140
	guaranteed_moves = [BrambleBashMove]
	extra_moves = []
