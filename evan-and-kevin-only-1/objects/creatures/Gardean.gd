class_name GardeanCreature extends PlantCreature

func ready_creature():
	display_name = "Gardean"
	sprite_path = load("res://assets/creatures/gardean.png")
	spawn_anim = "Rise"
	descr = "Revered deity that protects the beauty of life. Lives 1,000 years before willingly feeding itself to the flowers it grows. Were it to refuse this fate, its body would corrupt and grow uncontrollably, and it would absorb all life around it."
	base_health = 160
	base_power = 35
	base_speed = 105
	guaranteed_moves = [BrambleBashMove, MercyMove, PhotosynthesisMove, CompostMove]
	extra_moves = [TimberMove, DownpourMove, SavingGraceMove, ThousandYearsMove, HealingWaterMove]
