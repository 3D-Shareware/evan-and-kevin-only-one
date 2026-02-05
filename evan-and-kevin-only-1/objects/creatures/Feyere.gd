class_name FeyereCreature extends FireCreature

func ready_creature():
	display_name = "Feyere"
	sprite_path = load("res://assets/creatures/feyere.png")
	spawn_anim = "Rise"
	descr = "Observes life forms from the core of the Earth. Rises only during chaotic times. Making eye contact with one will slowly scar your vision. Anything that it watches for too long doesn’t have much longer to live."
	base_health = 170
	base_power = 105
	base_speed = 25
	guaranteed_moves = [FireboltMove, ThermalLaserMove, FlashfireMove, DemonsFireMove]
	extra_moves = [HotLavaMove, StrangeFlashMove, HauntMove, DrySpellMove, CombustMove]
