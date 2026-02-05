class_name CompostedStatus extends BaseStatus

func _init() -> void:
	display_name = "Compost"
	descr = "Next creature summoned on this side has 60% more Health."
	element_id = 0
	is_terrain = true
	summon_boost = true
	tied_to_foe = false
	lasts_one_turn = false

func on_summon(user: BaseCreature) -> String:
	lasts_one_turn = true
	@warning_ignore("narrowing_conversion")
	user.max_health *= 1.6
	@warning_ignore("narrowing_conversion")
	user.health *= 1.6
	return user.display_name + " consumed compost! Increased Health by 60%!"
