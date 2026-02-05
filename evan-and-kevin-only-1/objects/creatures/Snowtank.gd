class_name SnowtankCreature extends IceCreature

func ready_creature():
	display_name = "Snowtank"
	sprite_path = load("res://assets/creatures/snowtank.png")
	spawn_anim = "Dash"
	descr = "Built when a snowball fight went too far. Locks on to its foes and fires upon them, never stopping for a moment. Don’t let its dapper appearance fool you, for this tank does not play fair."
	base_health = 125
	base_power = 145
	base_speed = 30
	guaranteed_moves = [IcicleMove, HailfireMove, AccumulateMove, SlushMove]
	extra_moves = [SnowBombMove, BrambleBashMove, ThermalLaserMove, SnowdriftMove, SmogMove]
