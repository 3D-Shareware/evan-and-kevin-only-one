class_name FlamengoCreature extends FireCreature

var stance = "speed"

func ready_creature():
	display_name = "Flamengo"
	sprite_path = load("res://assets/creatures/flamengo_speed.png")
	spawn_anim = "Teleport"
	descr = "Has trained for 100 years. Fights without vision to focus on the power of its soul. Determined to bring balance to the world, and can tap into the power of life or death in its leg to deliver mighty kicks."
	base_health = 50
	base_power = 100
	base_speed = 150
	guaranteed_moves = [BurningSoulMove, BurningDemonMove, ShadowTraceMove, StanceChangeMove]
	extra_moves = [HauntMove, DemonsFireMove, FlashfireMove, LiftoffMove, PassOnMove]

func change_stance():
	if stance == "speed":
		stance = "power"
	else:
		stance = "speed"
	sprite.texture = load("res://assets/creatures/flamengo_" + stance + ".png")
