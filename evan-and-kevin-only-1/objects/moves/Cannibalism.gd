class_name CannabalismMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["plague"]
	deals_damage = false
	kills_user = false
	move_name = "Cannibalism"
	move_animation = "Squash"
	descr = "User heals all Health, increases Power and Speed by 30%, and decreases max Health by 30%."

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	user.take_damage(0, false)
	@warning_ignore("narrowing_conversion")
	var heal = str(user.heal_damage(user.max_health))
	@warning_ignore("narrowing_conversion")
	user.power *= 1.3
	@warning_ignore("narrowing_conversion")
	user.speed *= 1.3
	@warning_ignore("narrowing_conversion")
	user.max_health *= 0.7
	@warning_ignore("narrowing_conversion")
	user.health *= 0.7
	return user.display_name + " healed " + heal + " Health! Increased Power and Speed by 30%! Decreased max Health by 30%!"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.armor and user.health <= 0.3 * user.max_health:
		return 1
	return 0
