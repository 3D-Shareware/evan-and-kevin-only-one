class_name ShootingStarMove extends BaseMove

func _init() -> void:
	damage = 100
	action_speed = 100
	accuracy = 100
	element_id = elements["light"]
	deals_damage = true
	kills_user = false
	move_name = "Shooting Star"
	move_animation = "Melee"
	descr = "User’s Speed determines damage. Cuts user’s Speed by 30% afterward."

func get_move_specific_damage(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> float:
	return user.speed * self.damage

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	@warning_ignore("narrowing_conversion")
	user.speed = max(user.speed * 0.7, 1)
	return user.display_name + "'s Speed cut by 30%!"
