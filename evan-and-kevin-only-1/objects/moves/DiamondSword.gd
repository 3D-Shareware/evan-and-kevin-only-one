class_name DiamondSwordMove extends BaseMove

func _init() -> void:
	damage = 95
	action_speed = 100
	accuracy = 100
	element_id = elements["earth"]
	deals_damage = true
	kills_user = false
	move_name = "Diamond Sword"
	move_animation = "Melee"
	descr = "Breaks Armored foes, instantly defeating them."

func on_hit(_user:BaseCreature, target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	if target.armor:
		target.armor = 0
		return "[color=#fff700]" + target.display_name + " was sliced in two![/color]"
	else:
		return ""

func ai_priority(_user: BaseCreature, target: BaseCreature, _battle_properties: Array) -> int:
	if target.armor:
		return 7
	return 0
