class_name SmeltynxCreature extends FireCreature

func ready_creature():
	display_name = "Smeltynx"
	sprite_path = load("res://assets/creatures/smeltynx.png")
	spawn_anim = "Heavy"
	base_health = 160
	base_power = 80
	base_speed = 60
	guaranteed_moves = [FlashfireMove, ArmorForgeMove]
	extra_moves = []
