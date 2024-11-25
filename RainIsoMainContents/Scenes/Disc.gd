extends Area

const pressed_distance = 0.1

onready var press_sound = $AudioStreamPlayer

var pressed = false
var button_down = false

export(Material) var material

signal pressed
signal unpressed
signal button_down
signal button_up

func _on_Button_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		button_down = !button_down
		
		if button_down:
			emit_signal("button_down")
			press_sound.play()
		else:
			emit_signal("button_up")
			press_sound.play()
