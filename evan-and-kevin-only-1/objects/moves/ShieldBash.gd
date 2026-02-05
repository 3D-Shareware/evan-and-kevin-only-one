class_name ShieldBashMove extends BaseMove

func _init() -> void:
	damage = 50
	action_speed = 100
	accuracy = 100
	element_id = elements["light"]
	deals_damage = true
	kills_user = false
	move_name = "Shield Bash"
	move_animation = "Melee"
	descr = "User’s current Armor determines damage."

func get_move_specific_damage(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> float:
	return user.armor * self.damage

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if 0.5 * user.armor >= user.power:
		return 10
	return -5
