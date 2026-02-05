class_name BlubbitCreature extends WaterCreature

func ready_creature():
	display_name = "Blubbit"
	sprite_path = load("res://assets/creatures/blubbit.png")
	spawn_anim = "Bounce"
	descr = "Inhales oxygen to form bubbles, which it uses to hold its breath underwater. These bubbles can clean any surface and withstand explosions. During the spring, they gather in groups and release clouds of bubbles that span miles in diameter."
	base_health = 155
	base_power = 50
	base_speed = 95
	guaranteed_moves = [ExtinguishMove, HealingWaterMove, DozeMove, SafetyBubbleMove]
	extra_moves = [DownpourMove, CrushMove, SmogMove, FunkyTonicMove, SavingGraceMove]
