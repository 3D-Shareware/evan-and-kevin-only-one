class_name RockstrichCreature extends EarthCreature

func ready_creature():
	display_name = "Rockstrich"
	sprite_path = load("res://assets/creatures/rockstrich.png")
	spawn_anim = "Dash"
	base_health = 65
	base_power = 120
	base_speed = 115
	guaranteed_moves = [CollisionCourseMove, RockLobMove]
	extra_moves = []
