class_name StrikingTalisman extends BaseTalisman

func _init() -> void:
	display_name = "Striking"
	texture_path = "striking"
	descr = "This creature's first move always goes first and flinches the foe."

func play_talisman(user: BaseCreature, _target: BaseCreature, battle_properties: Array):
	user.apply_status(StrikingStatus.new(), battle_properties)
