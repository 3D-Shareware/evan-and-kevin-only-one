class_name ThornyStatus extends BaseStatus

func _init() -> void:
	display_name = "Thorny"
	descr = "Creatures summoned on this side lose 20% of their Health, or 40% if weak to Plant. Plant is immune."
	element_id = elements["plant"]
	is_terrain = true
	tied_to_foe = false
	lasts_one_turn = false

func on_summon(user: BaseCreature) -> String:
	if user.armor > 0:
		return ""
	if user.weak_to_type(element_id):
		@warning_ignore("narrowing_conversion")
		return "[color=#fff700]" + user.display_name + " was prickled by thorns for " + str(user.take_damage(0.4 * user.max_health, false)) + " damage![/color]"
	@warning_ignore("narrowing_conversion")
	return user.display_name + " was prickled by thorns for " + str(user.take_damage(0.2 * user.max_health, false)) + " damage!"
