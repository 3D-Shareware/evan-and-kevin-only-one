class_name CaongCreature extends LightCreature

func ready_creature():
	display_name = "Caong"
	sprite_path = load("res://assets/creatures/caong.png")
	spawn_anim = "Teleport"
	descr = "Divine being that only shows itself to save people from disaster. Favors people who live kind and generous lives. When it isn’t busy saving people, it’s assumed to be drifting aimlessly in the heavens."
	base_health = 135
	base_power = 25
	base_speed = 140
	guaranteed_moves = [LightRayMove, DivineInterventionMove, SavingGraceMove, LastWishMove]
	extra_moves = [LightspeedMove, ExtinguishMove, StrangeFlashMove, HealingWaterMove, LiftoffMove]
