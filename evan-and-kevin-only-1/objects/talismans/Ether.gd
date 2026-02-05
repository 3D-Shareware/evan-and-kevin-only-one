class_name EtherTalisman extends BaseTalisman

func _init() -> void:
	display_name = "Ether"
	texture_path = "ether"
	descr = "This creature's moves are strong against every Element, and this creature is weak to every Element."

func play_talisman(user: BaseCreature, _target: BaseCreature, _battle_properties: Array):
	user.element_id = user.elements["ether"]
	user.weaknesses = [0, 1, 2, 3, 4, 5, 6, 7, 8]
	for i in user.moveset:
		i.element_id = user.elements["ether"]
