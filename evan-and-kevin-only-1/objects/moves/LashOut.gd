class_name LashOutMove extends BaseMove

func _init() -> void:
	damage = 50
	action_speed = 130
	accuracy = 90
	element_id = elements["plague"]
	deals_damage = true
	kills_user = false
	move_name = "Lash Out"
	move_animation = "Melee"
	descr = "Deals double damage against foes who have full Health."

func get_move_specific_damage(user: BaseCreature, target: BaseCreature, _battle_properties: Array) -> float:
	if (target.armor > 0 and target.armor == target.max_armor) or (target.health > 0 and target.health == target.max_health):
		return user.power * self.damage * 2
	return user.power * self.damage

func ai_priority(_user: BaseCreature, target: BaseCreature, _battle_properties: Array) -> int:
	if target.health == target.max_health and !target.armor:
		return 3
	return 0
