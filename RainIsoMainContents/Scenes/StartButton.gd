extends Node2D

var selected = false

func _on_Cursor_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			selected = true
		else:
			selected = false
			
func _process(delta):
	if selected:
		followMouse()
		
func followMouse():
	position = get_global_mouse_position()
