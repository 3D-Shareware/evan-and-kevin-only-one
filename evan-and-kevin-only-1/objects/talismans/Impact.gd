class_name ImpactTalisman extends BaseTalisman

func _init() -> void:
	display_name = "Impact"
	texture_path = "impact"
	descr = "This creature's first attack deals 50% more damage."

func play_talisman(user: BaseCreature, _target: BaseCreature, battle_properties: Array):
	user.apply_status(ImpactStatus.new(), battle_properties)
