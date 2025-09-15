class_name SuperNovaCreature extends LightCreature

func ready_creature():
	display_name = "Super Nova"
	sprite_path = load("res://assets/creatures/super_nova.png")
	spawn_anim = "Dash"
	base_health = 40
	base_power = 85
	base_speed = 175
	guaranteed_moves = [DivineInterventionMove, LightRayMove]
	extra_moves = [ShootingStarMove]
