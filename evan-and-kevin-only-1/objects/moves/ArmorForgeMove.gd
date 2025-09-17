class_name ArmorForgeMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 100
	accuracy = 100
	element_id = elements["fire"]
	deals_damage = false
	move_name = "Armor Forge"
	move_animation = "Grow"
	descr = "Replaces Health with Armor equal to double user's max Health. Can't be used if already Armored.
	Armor can only be damaged by attacks, and isn't affected by healing, terrains, and the like."

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> String:
	if user.armor:
		return "[color=#ff1717]But " + user.display_name + " already suited up![/color]"
	else:
		user.health = 0
		user.max_armor = user.max_health * 2
		user.armor = user.max_armor
		return user.display_name + " suited up!"
