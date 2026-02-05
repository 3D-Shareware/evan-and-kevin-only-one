class_name ShatterMove extends BaseMove

func _init() -> void:
	damage = 250
	action_speed = 130
	accuracy = 70
	element_id = elements["ice"]
	deals_damage = true
	kills_user = true
	move_name = "Shatter"
	move_animation = "Explode"
	descr = ""

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	user.health = 0
	user.armor = 0
	return "[color=#ff1717]" + user.display_name + " split into a million shards![/color]"
