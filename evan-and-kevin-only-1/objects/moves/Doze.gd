class_name DozeMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["water"]
	deals_damage = false
	kills_user = false
	move_name = "Doze"
	move_animation = "Squash"
	descr = "Makes user Drowsy, healing 10% of user's Health every turn."

func on_hit(user: BaseCreature, _target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	user.apply_status(DrowsyStatus.new(), battle_properties)
	return user.display_name + " started dozing off!"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
