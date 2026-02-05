class_name CompostMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 150
	accuracy = 100
	element_id = elements["plant"]
	deals_damage = false
	kills_user = true
	move_name = "Compost"
	move_animation = "Squash"
	descr = "The next creature user summons has 60% more Health."

func on_hit(user: BaseCreature, _target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	user.health = 0
	user.armor = 0
	user.apply_status(CompostedStatus.new(), battle_properties)
	return "[color=#ff1717]" + user.display_name + " sowed seeds for its team![/color]"
