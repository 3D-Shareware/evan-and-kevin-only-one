class_name PhotosynthesisMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["plant"]
	deals_damage = false
	kills_user = false
	move_name = "Photosynthesis"
	move_animation = "Grow"
	descr = "Heals 30% of user's Health, and user's next Light attack deals 100% more damage. If foe is a Light creature, heals 60% Health insteaed, and foe loses 30% Health."

func on_hit(user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if target.element_id == elements["light"]:
		user.apply_status(PhotosynthesizedStatus.new(), battle_properties)
		@warning_ignore("narrowing_conversion")
		return "[color=#fff700]" + user.display_name + " healed " + str(user.heal_damage(user.max_health * 0.6)) + " Health! " + target.display_name + " took " + str(target.take_damage(target.max_health * 0.3, false)) + " damage! Light flows within " + user.display_name + "![/color]"
	else:
		user.apply_status(PhotosynthesizedStatus.new(), battle_properties)
		@warning_ignore("narrowing_conversion")
		return user.display_name + " healed " + str(user.heal_damage(user.max_health * 0.3)) + " Health! Light flows within " + user.display_name + "!"

func ai_priority(user: BaseCreature, target: BaseCreature, _battle_properties: Array) -> int:
	if target.element_id == elements["light"] and !target.armor:
		return 10
	elif !user.armor and user.health <= 0.3 * user.max_health:
		return 1
	return 0
