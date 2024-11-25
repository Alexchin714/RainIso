extends Control

func _process(delta):
	if Input.is_action_just_pressed("toggle_editor"):
		visible = !visible
	pass
