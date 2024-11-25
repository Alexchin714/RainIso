extends ColorPickerButton

onready var object_cursor = get_node("/root/Editor/Editor_Objects")

func _on_MAINCOLOR_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()
	pass # Replace with function body.

func _on_MAINCOLOR_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()
	pass # Replace with function body.
