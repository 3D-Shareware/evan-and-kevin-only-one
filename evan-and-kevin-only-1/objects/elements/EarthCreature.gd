class_name EarthCreature extends BaseCreature

func ready_element():
	element_id = elements["earth"]
	weaknesses = [elements["plant"], elements["water"], elements["ether"]]
