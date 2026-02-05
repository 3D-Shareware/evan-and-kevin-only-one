class_name BamboldCreature extends PlantCreature

func ready_creature():
	display_name = "Bambold"
	sprite_path = load("res://assets/creatures/bambold.png")
	spawn_anim = "Rise"
	descr = "Its life is near its end, but it is forever satisfied knowing that its teachings will pass on to every generation. In battle, its patience is unrivaled, and it will sit perfectly still while waiting for a foe to make a move."
	base_health = 100
	base_power = 115
	base_speed = 85
	guaranteed_moves = [TimberMove, BambooShootMove, PhotosynthesisMove, ThousandYearsMove]
	extra_moves = [DozeMove, PassOnMove, SavingGraceMove, ThornsFirstMove, RollMove]
