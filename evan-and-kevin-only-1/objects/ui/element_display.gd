extends Sprite2D

func _on_element_button_mouse_entered() -> void:
	get_parent().describe_element(frame)


func _on_element_button_mouse_exited() -> void:
	get_parent().update_text_to_display("", true)
