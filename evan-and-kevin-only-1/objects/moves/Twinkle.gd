class_name TwinkleMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 70
	accuracy = 100
	element_id = elements["ether"]
	deals_damage = false
	kills_user = false
	move_name = "Twinkle"
	move_animation = "Grow"
	descr = "Makes all of user's moves strong against every element."

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	for i in user.moveset:
		i.element_id = elements["ether"]
	return user.display_name + " sparkles with ethereal might!"

func ai_priority(user: BaseCreature, target: BaseCreature, _battle_properties: Array) -> int:
	if target.weak_to_type(user.element_id):
		return -2
	elif user.moveset[0].element_id == elements["ether"]:
		return -5
	return 3
