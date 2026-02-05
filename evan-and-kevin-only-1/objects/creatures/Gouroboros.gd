class_name GouroborosCreature extends PlagueCreature

func ready_creature():
	display_name = "Gouroboros"
	sprite_path = load("res://assets/creatures/gouroboros.png")
	spawn_anim = "Bounce"
	descr = "Ravenous snake whose venom is so strong it melts its own body. Driven purely by hunger, it eats anything that moves. When food is low, it has been observed consuming itself. It is unknown whether this is a useful evolutionary adaptation or a side effect of its neurotoxins."
	base_health = 145
	base_power = 75
	base_speed = 85
	guaranteed_moves = [PiercingVenomMove, BanefulStrikeMove, LashOutMove, CannabalismMove]
	extra_moves = [RollMove, HauntMove, DrySpellMove, CrushMove, InsidesOutMove]
