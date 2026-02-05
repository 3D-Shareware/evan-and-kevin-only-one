class_name SinkMove extends BaseMove

func _init() -> void:
	damage = 100
	action_speed = 70
	accuracy = 70
	element_id = elements["water"]
	deals_damage = true
	kills_user = true
	move_name = "Sink"
	move_animation = "Melee"
	descr = "Instantly defeats the foe."

func on_hit(user: BaseCreature, target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	if target.armor:
		return target.display_name + "'s armor protects it!"
	elif target.health:
		user.health = 0
		user.armor = 0
		target.health = 0
		return "[color=#ff1717]" + user.display_name + " and " + target.display_name + " sunk into the abyss![/color]"
	return "[color=#ff1717]But there was nothing to sink![/color]"

func ai_priority(user: BaseCreature, target: BaseCreature, _battle_properties: Array) -> int:
	if !user.armor and user.power < 4 * target.health:
		return 2
	return 0
