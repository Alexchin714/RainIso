extends Control

func _physics_process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene("res://Settings.tscn")
		
func transition():
	$AnimationPlayer.play("Display")

func _on_Button_pressed():
	get_tree().change_scene("res://Settings.tscn")


func _on_Button2_pressed():
	get_tree().change_scene("res://GameplaySettings.tscn")


func _on_Fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen



func _on_Smoothfix_pressed():
	pass # Replace with function body.


func _on_DisplayCheck_pressed():
	transition()

func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "Display":
		print("Display")


func _on_VSync_pressed():
	pass
