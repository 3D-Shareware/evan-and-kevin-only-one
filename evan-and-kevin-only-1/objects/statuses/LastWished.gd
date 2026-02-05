class_name LastWishedStatus extends BaseStatus

func _init() -> void:
	display_name = "Last Wish"
	descr = "Next creature summoned on this side has all stats increased by 30%."
	element_id = 0
	is_terrain = true
	summon_boost = true
	tied_to_foe = false
	lasts_one_turn = false

func on_summon(user: BaseCreature) -> String:
	lasts_one_turn = true
	@warning_ignore("narrowing_conversion")
	user.max_health *= 1.3
	@warning_ignore("narrowing_conversion")
	user.health *= 1.3
	@warning_ignore("narrowing_conversion")
	user.power *= 1.3
	@warning_ignore("narrowing_conversion")
	user.speed *= 1.3
	return user.display_name + " received the wish! Increased all stats by 30%!"
