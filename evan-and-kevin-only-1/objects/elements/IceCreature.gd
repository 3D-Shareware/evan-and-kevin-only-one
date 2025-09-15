class_name IceCreature extends BaseCreature

func ready_element():
	element_id = elements["ice"]
	weaknesses = [elements["fire"], elements["light"]]
