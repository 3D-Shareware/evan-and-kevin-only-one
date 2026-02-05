extends Sprite2D

@export var team = 0
@export var id = 0

func _on_texture_button_mouse_entered() -> void:
	get_parent().describe_status(team, id)

func _on_texture_button_mouse_exited() -> void:
	get_parent().update_text_to_display("", true)
