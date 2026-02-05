class_name SmeltynxCreature extends FireCreature

func ready_creature():
	display_name = "Smeltynx"
	sprite_path = load("res://assets/creatures/smeltynx.png")
	spawn_anim = "Heavy"
	descr = "Cat whose body is encased in a superheated steel forge. How the animal survives inside the forge is beyond scientific comprehension. Historically used in wars to both produce weapons and incinerate enemies."
	base_health = 160
	base_power = 80
	base_speed = 60
	guaranteed_moves = [HotLavaMove, HeatBlastMove, SuperheatMove, ArmorForgeMove]
	extra_moves = [FireboltMove, CombustMove, PressurizeMove, CrushMove, FlashfireMove]
