class_name SimpleTalisman extends BaseTalisman

func _init() -> void:
	display_name = "Simple"
	texture_path = "simple"
	descr = "This creature has no weaknesses, but the foe is weak to none of this creature's moves."

func play_talisman(user: BaseCreature, _target: BaseCreature, _battle_properties: Array):
	user.element_id = user.elements["none"]
	user.weaknesses = [user.elements["ether"]]
	for i in user.moveset:
		i.element_id = user.elements["none"]
