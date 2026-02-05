class_name AlchemouseCreature extends PlagueCreature

func ready_creature():
	display_name = "Alchemouse"
	sprite_path = load("res://assets/creatures/alchemouse.png")
	spawn_anim = "Teleport"
	descr = "Highly intelligent rodent that survived a lab accident. Wears another rat’s skull as a fume hood. Brews grotesque potions and drinks them to sustain itself. Could find the cure to any disease if it wanted to, but it would rather turn into a dinosaur."
	base_health = 75
	base_power = 55
	base_speed = 170
	guaranteed_moves = [BanefulStrikeMove, SmogMove, FunkyTonicMove, TransmutationMove]
	extra_moves = [PiercingVenomMove, DownpourMove, TwinkleMove, HotLavaMove, HauntMove]
