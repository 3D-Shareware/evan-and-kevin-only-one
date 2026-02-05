class_name FreezingPointMove extends BaseMove

func _init() -> void:
	damage = 100
	action_speed = 100
	accuracy = 90
	element_id = elements["ice"]
	deals_damage = true
	kills_user = false
	move_name = "Freezing Point"
	move_animation = "Melee"
	descr = "Deals 50% more damage if foe is weak to this move."

func on_hit(_user: BaseCreature, target: BaseCreature, _battle_properties: Array, _talismans: Array) -> String:
	if element_id in target.weaknesses:
		return "[color=#fff700]Weakness exploited![/color]"
	return ""

func get_move_specific_damage(user: BaseCreature, target: BaseCreature, _battle_properties: Array) -> float:
	if element_id in target.weaknesses:
		return user.power * self.damage * 1.5
	return user.power * self.damage
