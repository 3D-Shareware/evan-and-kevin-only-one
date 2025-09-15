class_name FeyereCreature extends FireCreature

func ready_creature():
	display_name = "Feyere"
	sprite_path = load("res://assets/creatures/feyere.png")
	spawn_anim = "Rise"
	base_health = 170
	base_power = 105
	base_speed = 25
	guaranteed_moves = [FireboltMove]
	extra_moves = [FlashfireMove]
