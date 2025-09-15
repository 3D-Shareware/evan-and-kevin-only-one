class_name PlagueCreature extends BaseCreature

func ready_element():
	element_id = elements["plague"]
	weaknesses = [elements["fire"], elements["light"]]
