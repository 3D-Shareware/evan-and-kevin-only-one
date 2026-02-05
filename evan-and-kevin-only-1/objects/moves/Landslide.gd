class_name LandslideMove extends BaseMove

func _init() -> void:
	damage = 135
	action_speed = 70
	accuracy = 100
	element_id = elements["earth"]
	deals_damage = true
	kills_user = false
	move_name = "Landslide"
	move_animation = "Stomp"
	descr = "Makes the opposing terrain Rough."

func on_hit(_user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if target.apply_status(RoughStatus.new(), battle_properties):
		return target.display_name + "'s side got rough!"
	return ""
