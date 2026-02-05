class_name MercyMove extends BaseMove

func _init() -> void:
	damage = 75
	action_speed = 100
	accuracy = 100
	element_id = elements["light"]
	deals_damage = true
	kills_user = false
	move_name = "Mercy"
	move_animation = "Melee"
	descr = "If foe has 50% Health or less, this move goes first."

func always_goes_first(_user: BaseCreature, target: BaseCreature, _moves: Array) -> bool:
	if target.health <= 0.5 * target.max_health:
		return true
	return false

func ai_priority(_user: BaseCreature, target: BaseCreature, _battle_properties: Array) -> int:
	if target.health <= 0.5 * target.max_health and !target.armor:
		return 1
	return 0
