extends Control

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().quit()
