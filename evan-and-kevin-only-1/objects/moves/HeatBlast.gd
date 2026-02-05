class_name HeatBlastMove extends BaseMove

func _init() -> void:
	damage = 160
	action_speed = 100
	accuracy = 100
	element_id = elements["fire"]
	deals_damage = true
	kills_user = false
	move_name = "Heat Blast"
	move_animation = "Divine"
	descr = "Can only be used once."

func on_hit(user: BaseCreature, _target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	user.moveset.pop_at(user.moveset.find(self))
	return ""
