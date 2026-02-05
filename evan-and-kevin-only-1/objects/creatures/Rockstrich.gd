class_name RockstrichCreature extends EarthCreature

func ready_creature():
	display_name = "Rockstrich"
	sprite_path = load("res://assets/creatures/rockstrich.png")
	spawn_anim = "Dash"
	descr = "Ostrich with a rocky shell. When threatened, it tucks into its shell and rolls at high speeds. It can’t see when it’s in its shell, so its habitat is littered with craters from everything it slams into. Not a very intelligent creature."
	base_health = 65
	base_power = 120
	base_speed = 115
	guaranteed_moves = [CollisionCourseMove, RollMove, CrushMove, ChickenOutMove]
	extra_moves = [FallingRockMove, DrySpellMove, LiftoffMove, HardenMove, TremorMove]
