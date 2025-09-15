class_name FireCreature extends BaseCreature

func ready_element():
	element_id = elements["fire"]
	weaknesses = [elements["water"], elements["earth"]]
