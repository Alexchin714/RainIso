extends CanvasLayer

func _on_Button_pressed():
	$AnimationPlayer.play_backwards("down")

func _on_BGButton_pressed():
	$Panel/FileDialog.show()

func _on_back_pressed():
	$AnimationPlayer.play_backwards("down")
