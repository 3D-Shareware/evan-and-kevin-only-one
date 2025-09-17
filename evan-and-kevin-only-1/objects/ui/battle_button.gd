extends TextureButton

@onready var sprite = $"Element"
@onready var label = $"RichTextLabel"

var id = 0

func set_element_and_text(element_id: int, txt: String):
	sprite.frame = element_id
	label.text = txt


func _on_mouse_entered() -> void:
	get_parent().describe_button(id)


func _on_pressed() -> void:
	get_parent().button_pressed(id)
