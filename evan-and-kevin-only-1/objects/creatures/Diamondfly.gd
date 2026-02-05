class_name DiamondflyCreature extends EarthCreature

func ready_creature():
	display_name = "Diamondfly"
	sprite_path = load("res://assets/creatures/diamondfly.png")
	spawn_anim = "Dash"
	descr = "Beautiful insect that flies despite having literal diamonds for wings. Often hunted for said diamonds, but those very same diamonds give it razor-sharp fangs which it uses to slice foes in two."
	base_health = 40
	base_power = 165
	base_speed = 90
	guaranteed_moves = [DiamondSwordMove, LightRayMove, FallingRockMove, LiftoffMove]
	extra_moves = [TwinkleMove, DrillSpinMove, StoneThrowMove, PressurizeMove, HardenMove]
