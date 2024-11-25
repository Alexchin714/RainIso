extends ColorRect

func _on_Button_pressed():
	$Timer.start()
	$Button.disabled = true
	$TimerTheSecond.start()
	$AnimationPlayer.play("activate")
	$AudioStreamPlayer.play()

func _on_Timer_timeout():
	get_tree().change_scene("res://RainIsoMainContents/MainLevels/MelodyTown.tscn")

func _on_TimerTheSecond_timeout():
	$AnimationPlayer.play_backwards("activate")
