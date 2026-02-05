class_name PassOnStatus extends BaseStatus

var stored_power = 0
var stored_speed = 0

func _init() -> void:
	display_name = "Pass On"
	descr = "Next creature summoned on this side gets additional Power and Speed."
	element_id = 0
	is_terrain = true
	summon_boost = true
	tied_to_foe = false
	lasts_one_turn = false

func on_summon(user: BaseCreature) -> String:
	lasts_one_turn = true
	@warning_ignore("narrowing_conversion")
	user.power += stored_power
	@warning_ignore("narrowing_conversion")
	user.speed += stored_speed
	return user.display_name + " received great strength! Increased Power by " + str(stored_power) + " and Speed by " + str(stored_speed) + "!"
