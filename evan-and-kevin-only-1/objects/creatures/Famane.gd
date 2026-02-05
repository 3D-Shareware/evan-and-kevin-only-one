class_name FamaneCreature extends PlagueCreature

func ready_creature():
	display_name = "Famane"
	sprite_path = load("res://assets/creatures/famane.png")
	spawn_anim = "Dash"
	descr = "Only appears during great tragedies. Smells horrendous, and so much as laying eyes on one brings pain all over the body. Legend has it that if four of them are seen in one place, the world is coming to an end."
	base_health = 105
	base_power = 85
	base_speed = 110
	guaranteed_moves = [BanefulStrikeMove, ApocalypseMove, HauntMove, DemonsFireMove]
	extra_moves = [SmogMove, FreezingPointMove, FlashfireMove, LashOutMove, DrySpellMove]
