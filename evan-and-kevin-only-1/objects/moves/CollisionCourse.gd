class_name CollisionCourseMove extends BaseMove

func _init() -> void:
	damage = 120
	action_speed = 130
	accuracy = 90
	element_id = elements["earth"]
	deals_damage = true
	kills_user = false
	move_name = "Collision Course"
	move_animation = "Melee"
	descr = "User loses 25% Health."

func on_hit(user:BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	if user.boss:
		@warning_ignore("narrowing_conversion")
		return user.display_name + " took " + str(user.take_damage(0.125 * user.max_health, false)) + " damage!"
	else:
		@warning_ignore("narrowing_conversion")
		return user.display_name + " took " + str(user.take_damage(0.25 * user.max_health, false)) + " damage!"
