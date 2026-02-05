class_name ArmorForgeMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 100
	accuracy = 100
	element_id = elements["fire"]
	deals_damage = false
	kills_user = false
	move_name = "Armor Forge"
	move_animation = "Grow"
	descr = "Replaces Health with Armor, equal to 150% of user's max Health. Can't be used if already Armored. Armor prevents flinching and healing, and can only be damaged directly."

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	if user.armor:
		return "[color=#ff1717]But " + user.display_name + " already suited up![/color]"
	else:
		@warning_ignore("narrowing_conversion")
		user.max_armor = user.max_health * 1.5
		user.armor = user.max_armor
		user.max_health = 0
		user.health = 0
		return user.display_name + " suited up!"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.turns_alive:
		return 3
	elif user.armor:
		return -3
	elif user.health <= 0.3 * user.max_health:
		return 6
	return 0
