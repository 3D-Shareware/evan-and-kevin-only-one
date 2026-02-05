class_name AnchoringTalisman extends BaseTalisman

func _init() -> void:
	display_name = "Anchoring"
	texture_path = "anchoring"
	descr = "This creature survives one fatal blow."

func play_talisman(user: BaseCreature, _target: BaseCreature, battle_properties: Array):
	user.apply_status(AnchoredStatus.new(), battle_properties)
