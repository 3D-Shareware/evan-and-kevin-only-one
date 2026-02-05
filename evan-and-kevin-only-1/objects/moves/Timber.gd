class_name TimberMove extends BaseMove

func _init() -> void:
	damage = 110
	action_speed = 100
	accuracy = 85
	element_id = elements["plant"]
	deals_damage = true
	kills_user = false
	move_name = "Timber"
	move_animation = "Stomp"
	descr = "If foe flinches or is weak to this move, the opposing terrain becomes Sapped."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if target.weak_to_type(element_id) and target.apply_status(SappedStatus.new(), battle_properties):
		return "Sapped " + target.display_name + "'s side!"
	return ""

func flinch_effects(_user: BaseCreature, target: BaseCreature, battle_properties: Array) -> String:
	if target.apply_status(SappedStatus.new(), battle_properties):
		return "Sapped " + target.display_name + "'s side!"
	return ""
