class_name TremorMove extends BaseMove

func _init() -> void:
	damage = 90
	action_speed = 100
	accuracy = 100
	element_id = elements["earth"]
	deals_damage = true
	kills_user = false
	move_name = "Tremor"
	move_animation = "Stomp"
	descr = "If foe flinches or is weak to this move, the opposing terrain becomes Rough."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if target.weak_to_type(element_id) and target.apply_status(RoughStatus.new(), battle_properties):
		return target.display_name + "'s side got rough!"
	return ""

func flinch_effects(_user: BaseCreature, target: BaseCreature, battle_properties: Array) -> String:
	if target.apply_status(RoughStatus.new(), battle_properties):
		return target.display_name + "'s side got rough!"
	return ""
