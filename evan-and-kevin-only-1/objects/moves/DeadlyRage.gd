class_name DeadlyRageMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["plague"]
	deals_damage = false
	kills_user = false
	move_name = "Primal Rage"
	move_animation = "Squash"
	descr = "Doubles all of user's stats, but user will be defeated in 3 turns."

func on_hit(user: BaseCreature, _target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	user.max_health *= 2
	user.health *= 2
	user.max_armor *= 2
	user.armor *= 2
	user.power *= 2
	user.speed *= 2
	user.apply_status(EnragedStatus.new(), battle_properties)
	return user.display_name + "'s stats increased by 100%! " + user.display_name + " entered a fit of rage!"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
