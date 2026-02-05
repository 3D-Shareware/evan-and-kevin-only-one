class_name HardenMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["earth"]
	deals_damage = false
	kills_user = false
	move_name = "Harden"
	move_animation = "Squash"
	descr = "Makes user Hard, reducing incoming damage by 50%."

func on_hit(user: BaseCreature, _target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	user.apply_status(HardStatus.new(), battle_properties)
	return user.display_name + " got hard!"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	return 0
