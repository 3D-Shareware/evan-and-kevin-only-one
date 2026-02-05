class_name StrangeFlashMove extends BaseMove

func _init() -> void:
	damage = 60
	action_speed = 130
	accuracy = 90
	element_id = elements["light"]
	deals_damage = true
	kills_user = false
	move_name = "Strange Flash"
	move_animation = "Launch"
	descr = "If foe flinches or is weak to this move, the opposing terrain becomes Filtered."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if target.weak_to_type(element_id) and target.apply_status(FilteredStatus.new(), battle_properties):
		return "Filtered " + target.display_name + "'s side!"
	return ""

func flinch_effects(_user: BaseCreature, target: BaseCreature, battle_properties: Array) -> String:
	if target.apply_status(FilteredStatus.new(), battle_properties):
		return "Filtered " + target.display_name + "'s side!"
	return ""
