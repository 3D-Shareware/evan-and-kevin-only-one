class_name ResentanaCreature extends PlagueCreature

func ready_creature():
	display_name = "Resentana"
	sprite_path = load("res://assets/creatures/resentana.png")
	spawn_anim = "Dash"
	descr = "Sword possessed by the soul of its fallen owner. It holds a grudge against its killer that can only be satisfied in blood. Once it exacts its revenge, the soul is freed to the afterlife, and the sword falls motionless to the ground."
	base_health = 25
	base_power = 160
	base_speed = 115
	guaranteed_moves = [BanefulStrikeMove, ShadowTraceMove, HauntMove, DemonsFireMove]
	extra_moves = [PiercingVenomMove, SubzeroSlashMove, FreezingPointMove, DiamondSwordMove, TwinkleMove]
