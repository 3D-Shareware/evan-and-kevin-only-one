class_name CollisionCourseMove extends BaseMove

func _init() -> void:
	damage = 140
	action_speed = 150
	accuracy = 90
	element_id = elements["earth"]
	deals_damage = true
	move_name = "Collision Course"
	move_animation = "Melee"
	descr = "User loses 25% Health."

func on_hit(user:BaseCreature, _target: BaseCreature, _battle_properties: Array) -> String:
	@warning_ignore("narrowing_conversion")
	user.health = max(user.health - 0.25 * user.max_health, 0)
	return user.display_name + "'s Health dropped by 25%!"
