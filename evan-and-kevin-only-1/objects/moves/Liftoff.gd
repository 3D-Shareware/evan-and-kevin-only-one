class_name LiftoffMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 100
	accuracy = 100
	element_id = elements["earth"]
	deals_damage = false
	kills_user = false
	move_name = "Liftoff"
	move_animation = "Grow"
	descr = "Increases user's Speed by 50%."

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	@warning_ignore("narrowing_conversion")
	user.speed *= 1.5
	return user.display_name + "'s Speed increased by 50%!"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
