class_name RegenerativeTalisman extends BaseTalisman

func _init() -> void:
	display_name = "Regenerative"
	texture_path = "regenerative"
	descr = "Every turn, this creature heals 10% of its Health."

func play_talisman(user: BaseCreature, _target: BaseCreature, battle_properties: Array):
	user.apply_status(RegenerativeStatus.new(), battle_properties)
