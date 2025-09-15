class_name ResentanaCreature extends PlagueCreature

func ready_creature():
	display_name = "Resentana"
	sprite_path = load("res://assets/creatures/resentana.png")
	spawn_anim = "Dash"
	base_health = 30
	base_power = 155
	base_speed = 115
	guaranteed_moves = [BanefulStrikeMove]
	extra_moves = [PiercingVenomMove]
