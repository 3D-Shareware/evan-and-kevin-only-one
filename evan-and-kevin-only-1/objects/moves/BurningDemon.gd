class_name BurningDemonMove extends BaseMove

func _init() -> void:
	damage = 95
	action_speed = 100
	accuracy = 90
	element_id = elements["plague"]
	deals_damage = true
	kills_user = false
	move_name = "Burning Demon"
	move_animation = "Melee"
	descr = "If user has more Power than foe, deals 50% more damage and opposing terrain becomes Melting."

func get_move_specific_damage(user: BaseCreature, target: BaseCreature, _battle_properties: Array) -> float:
	if user.power > target.power:
		return user.power * self.damage * 1.5
	return user.power * self.damage

func on_hit(user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if user.power > target.power and target.apply_status(MeltingStatus.new(), battle_properties):
		return target.display_name + "'s side started Melting!"
	return ""
