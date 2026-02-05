class_name DrowsyStatus extends BaseStatus

func _init() -> void:
	display_name = "Drowsy"
	descr = "Every turn, this creature heals 10% of its Health."
	element_id = 0
	is_terrain = false
	tied_to_foe = false
	lasts_one_turn = false

func end_of_turn(user: BaseCreature, _target: BaseCreature) -> String:
	@warning_ignore("narrowing_conversion")
	return user.display_name + " healed " + str(user.heal_damage(user.max_health * 0.1)) + " Health!"
