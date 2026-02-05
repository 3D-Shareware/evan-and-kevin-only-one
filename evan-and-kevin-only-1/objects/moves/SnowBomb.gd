class_name SnowBombMove extends BaseMove

func _init() -> void:
	damage = 110
	action_speed = 100
	accuracy = 85
	element_id = elements["ice"]
	deals_damage = true
	kills_user = false
	move_name = "Snow Bomb"
	move_animation = "Launch"
	descr = "If foe flinches or is weak to this move, the opposing terrain becomes Misty."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if target.weak_to_type(element_id) and target.apply_status(MistyStatus.new(), battle_properties):
		return target.display_name + "'s side got Misty!"
	return ""

func flinch_effects(_user: BaseCreature, target: BaseCreature, battle_properties: Array) -> String:
	if target.apply_status(MistyStatus.new(), battle_properties):
		return target.display_name + "'s side got Misty!"
	return ""
