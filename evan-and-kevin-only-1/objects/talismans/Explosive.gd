class_name ExplosiveTalisman extends BaseTalisman

func _init() -> void:
	display_name = "Explosive"
	texture_path = "explosive"
	descr = "When this creature is defeated, it deals damage equal to double its Power to the foe."

func play_talisman(user: BaseCreature, _target: BaseCreature, battle_properties: Array):
	user.apply_status(ExplosiveStatus.new(), battle_properties)
