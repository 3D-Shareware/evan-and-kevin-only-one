class_name WaterCreature extends BaseCreature

func ready_element():
	element_id = elements["water"]
	weaknesses = [elements["ice"], elements["plant"], elements["light"], elements["plague"], elements["ether"]]
