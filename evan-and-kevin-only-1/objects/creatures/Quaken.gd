class_name QuakenCreature extends EarthCreature

func ready_creature():
	display_name = "Quaken"
	sprite_path = load("res://assets/creatures/quaken.png")
	spawn_anim = "Drill"
	descr = "Colossal squid that lives deep underground. Digs through the earth in search of metal to eat. It means no harm, but tunnels dug by a Quaken can collapse entire villages."
	base_health = 165
	base_power = 55
	base_speed = 80
	guaranteed_moves = [TremorMove, StoneThrowMove, DrillSpinMove, DrySpellMove]
	extra_moves = [SinkMove, HotLavaMove, FallingRockMove, HardenMove, LandslideMove]
