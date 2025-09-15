class_name TimboarCreature extends PlantCreature

func ready_creature():
	display_name = "Timboar"
	sprite_path = load("res://assets/creatures/timboar.png")
	spawn_anim = "Dash"
	base_health = 125
	base_power = 90
	base_speed = 85
	guaranteed_moves = [TimberMove]
	extra_moves = [BrambleBashMove, TremorMove]
