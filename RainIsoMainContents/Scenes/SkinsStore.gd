extends Control

func _process(delta):
	$cash.text = "Cash :" + str(Global.score)

	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://TitleScreen.tscn")
