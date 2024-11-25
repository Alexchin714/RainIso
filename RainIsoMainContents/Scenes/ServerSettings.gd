extends Control

func _physics_process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene("res://DisplaySettings.tscn")

func _on_Button_pressed():
	get_tree().change_scene("res://DisplaySettings.tscn")


func _on_DashFX_pressed():
	pass
