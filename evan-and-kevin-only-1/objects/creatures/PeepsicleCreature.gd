class_name PeepsicleCreature extends IceCreature

func ready_creature():
	display_name = "Peepsicle"
	sprite_path = load("res://assets/creatures/peepsicle.png")
	spawn_anim = "Bounce"
	descr = "Juvenile of a larger bird of prey. Cozied up in its insulated fur, it can withstand harsh conditions. Defends itself from larger foes by wearing them down and then striking with its sharp beak."
	base_health = 140
	base_power = 85
	base_speed = 75
	guaranteed_moves = [IcicleMove]
	extra_moves = []
