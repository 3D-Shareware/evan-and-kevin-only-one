class_name JellfireCreature extends FireCreature

func ready_creature():
	display_name = "Jellfire"
	sprite_path = load("res://assets/creatures/jellfire.png")
	spawn_anim = "Bounce"
	descr = "The temperature inside its body is hotter than the surface of the sun. Floats aimlessly and causes forest fires. Its stingers can melt any surface. Prone to violently exploding if agitated. It’s safe to say this creature has no predators."
	base_health = 35
	base_power = 175
	base_speed = 90
	guaranteed_moves = [HotLavaMove, CombustMove, SuperheatMove, DemonsFireMove]
	extra_moves = [FireboltMove, FlashfireMove, LiftoffMove, HeatBlastMove, StrangeFlashMove]
