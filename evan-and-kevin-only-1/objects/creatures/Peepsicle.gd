class_name PeepsicleCreature extends IceCreature

func ready_creature():
	display_name = "Peepsicle"
	sprite_path = load("res://assets/creatures/peepsicle.png")
	spawn_anim = "Bounce"
	descr = "Juvenile of a larger bird of prey. Cozied up in its insulated fur, it can withstand the harshest of conditions. Attacks relentlessly when approached by striking with its sharp beak, so it's best to just let it enjoy its solitude."
	base_health = 140
	base_power = 85
	base_speed = 75
	guaranteed_moves = [IcicleMove, FreezingPointMove, AccumulateMove, SmogMove]
	extra_moves = [SnowBombMove, LashOutMove, ChickenOutMove, RollMove, ShatterMove]
