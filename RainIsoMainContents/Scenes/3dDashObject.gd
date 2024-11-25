extends Spatial

func _on_Area_body_entered(body):
	if Input.is_action_pressed("jump"):
		if body.name == "Player":
			body.moveVec.y = 60
	$Timer.start()
	$AnimationPlayer.play("Used")
	$Area/CollisionShape.set_deferred("disabled", true)

func _on_Timer_timeout():
	$AnimationPlayer.play_backwards("Used")
	$Area/CollisionShape.set_deferred("disabled", false)
