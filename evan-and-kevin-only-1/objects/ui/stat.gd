extends TextureButton

@export var id = 0

func _on_texture_button_mouse_entered() -> void:
	get_parent().get_parent().describe_stat(id)

func _on_texture_button_mouse_exited() -> void:
	get_parent().get_parent().update_text_to_display("", true)
