class_name LastWishMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 150
	accuracy = 100
	element_id = elements["light"]
	deals_damage = false
	kills_user = true
	move_name = "Last Wish"
	move_animation = "Grow"
	descr = "The next creature user summons has a 30% boost to all stats."

func on_hit(user: BaseCreature, _target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	user.health = 0
	user.armor = 0
	user.apply_status(LastWishedStatus.new(), battle_properties)
	return "[color=#ff1717]" + user.display_name + " sent a wish to its team![/color]"
