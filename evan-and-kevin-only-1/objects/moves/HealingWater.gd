class_name HealingWaterMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["water"]
	deals_damage = false
	kills_user = false
	move_name = "Healing Water"
	move_animation = "Grow"
	descr = "Heals 60% of user's Health."

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	@warning_ignore("narrowing_conversion")
	return user.display_name + " healed " + str(user.heal_damage(user.max_health * 0.6)) + " Health!"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.armor and user.health <= 0.3 * user.max_health:
		return 1
	return 0
