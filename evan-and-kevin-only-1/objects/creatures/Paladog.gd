class_name PaladogCreature extends LightCreature

func ready_creature():
	display_name = "Paladog"
	sprite_path = load("res://assets/creatures/paladog.png")
	spawn_anim = "Heavy"
	descr = "Loyal companion of a fallen ruler. It adorns itself with its late owner’s garments, and vows to bring justice to the world by calming those in distress. Bashes those who interfere with its mission with its huge shield. Tries very hard not to be led astray by dog treats."
	base_health = 135
	base_power = 115
	base_speed = 50
	guaranteed_moves = [JusticeMove, MercyMove, ShieldBashMove, ArmorForgeMove]
	extra_moves = [DivineInterventionMove, LastWishMove, SniffOutMove, LightRayMove, PurePowerMove]
