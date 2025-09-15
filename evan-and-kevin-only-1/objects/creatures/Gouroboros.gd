class_name GouroborosCreature extends PlagueCreature

func ready_creature():
	display_name = "Gouroboros"
	sprite_path = load("res://assets/creatures/gouroboros.png")
	spawn_anim = "Bounce"
	base_health = 145
	base_power = 75
	base_speed = 85
	guaranteed_moves = [PiercingVenomMove, LashOutMove]
	extra_moves = [BanefulStrikeMove]
