class_name HauntMove extends BaseMove

func _init() -> void:
	damage = 10
	action_speed = 130
	accuracy = 100
	element_id = elements["plague"]
	deals_damage = true
	kills_user = true
	move_name = "Haunt"
	move_animation = "Squash"
	descr = "Reduces all of foe's stats by 50%."

func on_hit(user:BaseCreature, target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	user.health = 0
	user.armor = 0
	@warning_ignore("narrowing_conversion")
	target.max_armor *= 0.5
	@warning_ignore("narrowing_conversion")
	target.armor *= 0.5
	@warning_ignore("narrowing_conversion")
	target.max_health *= 0.5
	@warning_ignore("narrowing_conversion")
	target.health *= 0.5
	@warning_ignore("narrowing_conversion")
	target.power *= 0.5
	@warning_ignore("narrowing_conversion")
	target.speed *= 0.5
	return "[color=#ff1717]" + user.display_name + " faded away! All of " + target.display_name + "'s stats cut by 50%!"
