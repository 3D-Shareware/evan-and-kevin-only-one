class_name AccumulateMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["ice"]
	deals_damage = false
	kills_user = false
	move_name = "Accumulate"
	move_animation = "Grow"
	descr = "Heals 30% of user's Health, and user's next Ice or Water attack deals 100% more damage."

func on_hit(user: BaseCreature, _target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	user.apply_status(AccumulatedStatus.new(), battle_properties)
	@warning_ignore("narrowing_conversion")
	return user.display_name + " healed " + str(user.heal_damage(user.max_health * 0.3)) + " Health! Precipitate empowers " + user.display_name + "!"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.armor and user.health <= 0.3 * user.max_health:
		return 1
	elif !user.turns_alive:
		return 3
	return 0
