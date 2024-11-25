extends Area2D

func _on_Timer_timeout():
	$HeartTimer.start()
	Engine.time_scale = 0.5

func _on_MelodyTownHeart_body_entered(body):
	$AnimationPlayer.play("HeartAni")
	yield(get_tree().create_timer(0.25), "timeout")
	Engine.time_scale = 0.2
	if body.name == "Player":
		body.set_physics_process(false)
		body.ani.stop()
	$Timer.start()
	
func _on_HeartTimer_timeout():
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/LevelSelectionScreen.tscn")
