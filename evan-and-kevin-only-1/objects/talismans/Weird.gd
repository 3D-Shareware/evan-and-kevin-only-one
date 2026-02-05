class_name WeirdTalisman extends BaseTalisman

func _init() -> void:
	display_name = "Weird"
	texture_path = "weird"
	descr = "Every turn, a random one of this creature's stats are increased by 20%."

func play_talisman(user: BaseCreature, _target: BaseCreature, battle_properties: Array):
	user.apply_status(WeirdStatus.new(), battle_properties)
