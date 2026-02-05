class_name SuperNovaCreature extends LightCreature

func ready_creature():
	display_name = "Super Nova"
	sprite_path = load("res://assets/creatures/super_nova.png")
	spawn_anim = "Dash"
	descr = "Falls out of the night sky in a prismatic trail of light. Flies faster than the speed of sound. People believe that seeing one will make your dreams come true. It knows this, and is proud of itself for being so influential."
	base_health = 40
	base_power = 85
	base_speed = 175
	guaranteed_moves = [LightRayMove, LightspeedMove, ShootingStarMove, LastWishMove]
	extra_moves = [JusticeMove, DivineInterventionMove, SavingGraceMove, StrangeFlashMove, TwinkleMove]
