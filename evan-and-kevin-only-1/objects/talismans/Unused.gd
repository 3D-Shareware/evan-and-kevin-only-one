class_name UnusuedTalisman extends BaseTalisman

func _init() -> void:
	display_name = "Unusued"
	texture_path = "none"
	descr = "You shouldn't have this!"

func play_talisman(_user: BaseCreature, _target: BaseCreature, _battle_properties: Array):
	pass
