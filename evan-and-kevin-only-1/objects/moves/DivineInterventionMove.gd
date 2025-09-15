class_name DivineInterventionMove extends BaseMove

func _init() -> void:
	damage = 10
	action_speed = 100
	accuracy = 25
	element_id = elements["light"]
	deals_damage = true
	move_name = "Divine Intervention"
	move_animation = "Launch"
	descr = "Instantly defeats the foe, and clears all terrain effects on foe's side."

func on_hit(target: BaseCreature) -> String:
	target.health = 0
	return "[color=#fff700]Instant KO![/color]"
