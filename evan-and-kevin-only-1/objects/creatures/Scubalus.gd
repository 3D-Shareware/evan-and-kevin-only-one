class_name ScubalusCreature extends WaterCreature

func ready_creature():
	display_name = "Scubalus"
	sprite_path = load("res://assets/creatures/scubalus.png")
	spawn_anim = "Rise"
	descr = "Deep-sea creature that most definitely stole its scuba equipment. Disturbingly intelligent, and has a fondness for metal objects. If backed into a corner, it will wrap its many tentacles around its enemy and drag them into the abyss."
	base_health = 135
	base_power = 40
	base_speed = 125
	guaranteed_moves = [DownpourMove, RollMove, SinkMove, InsidesOutMove]
	extra_moves = [ExtinguishMove, ArmorForgeMove, PressurizeMove, PlunderMove, HotLavaMove]
