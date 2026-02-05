class_name SlushMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["water"]
	deals_damage = false
	kills_user = false
	move_name = "Slush"
	move_animation = "Squash"
	descr = "If user is Ice, turns user and all of user's Ice moves into Water, and increases Power and Speed by 50%."

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	if user.element_id == elements["ice"]:
		user.element_id = elements["water"]
		user.weaknesses = [elements["ice"], elements["plant"], elements["light"], elements["plague"], elements["ether"]]
		for i in user.moveset:
			if i.element_id == elements["ice"]:
				i.element_id = elements["water"]
		@warning_ignore("narrowing_conversion")
		user.power *= 1.5
		@warning_ignore("narrowing_conversion")
		user.speed *= 1.5
		user.get_parent().clear_immune_ailments(user)
		return user.display_name + " turned into Water! Power and Speed increased by 50%!"
	else:
		return "[color=#ff1717]But " + user.display_name + " can't slush any further![/color]"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if user.element_id == elements["ice"]:
		return 1
	return -4
