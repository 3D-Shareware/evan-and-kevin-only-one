class_name AimingTalisman extends BaseTalisman

func _init() -> void:
	display_name = "Aiming"
	texture_path = "aiming"
	descr = "This creature's moves are 50% more accurate."

func play_talisman(user: BaseCreature, _target: BaseCreature, _battle_properties: Array):
	for i in user.moveset:
		i.accuracy *= 1.5
