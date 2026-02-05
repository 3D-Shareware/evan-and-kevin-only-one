class_name SturglockCreature extends WaterCreature

func ready_creature():
	display_name = "Sturglock"
	sprite_path = load("res://assets/creatures/sturglock.png")
	spawn_anim = "Teleport"
	descr = "Magical fish that can control the local weather. Protects the rivers and oceans with plentiful rains, and vanquishes those who threaten the waters. By levitating its eggs around itself, it heightens its magical power."
	base_health = 60
	base_power = 110
	base_speed = 130
	guaranteed_moves = [DownpourMove, CrashingWaveMove, ExtinguishMove, StormSpellMove]
	extra_moves = [HydroBurstMove, PressurizeMove, SafetyBubbleMove, HealingWaterMove, DrySpellMove]
