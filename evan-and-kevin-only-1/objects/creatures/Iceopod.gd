class_name IceopodCreature extends IceCreature

func ready_creature():
	display_name = "Iceopod"
	sprite_path = load("res://assets/creatures/iceopod.png")
	spawn_anim = "Dash"
	descr = "Ancient creature frozen in time. Has been running down prey and stabbing them with its claws of solid ice for millenia. Often tries to hunt creatures far larger than itself. Occasionally successful."
	base_health = 70
	base_power = 110
	base_speed = 120
	guaranteed_moves = [SubzeroSlashMove, ShatterMove, HardenMove, SlushMove]
	extra_moves = [IcicleMove, FreezingPointMove, DiamondSwordMove, DrillSpinMove, DeadlyRageMove]
