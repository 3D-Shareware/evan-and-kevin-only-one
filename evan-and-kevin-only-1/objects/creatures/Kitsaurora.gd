class_name KitsauroraCreature extends IceCreature

func ready_creature():
	display_name = "Kitsaurora"
	sprite_path = load("res://assets/creatures/kitsaurora.png")
	spawn_anim = "Dash"
	descr = "Rare being that lives in the tallest mountains. People track it down for months on end just to watch its dancing tails. Doesn’t like fighting, and prefers to get adversaries lost and then run away."
	base_health = 40
	base_power = 115
	base_speed = 145
	guaranteed_moves = [SnowBombMove, SnowdriftMove, AccumulateMove, ThousandYearsMove]
	extra_moves = [IcicleMove, SmogMove, SavingGraceMove, StrangeFlashMove, MercyMove]
