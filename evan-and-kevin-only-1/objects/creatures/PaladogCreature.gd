class_name PaladogCreature extends LightCreature

func ready_creature():
	display_name = "Paladog"
	sprite_path = load("res://assets/creatures/paladog.png")
	spawn_anim = "Heavy"
	base_health = 135
	base_power = 115
	base_speed = 50
	guaranteed_moves = [JusticeMove, ArmorForgeMove]
	extra_moves = [DivineInterventionMove]
