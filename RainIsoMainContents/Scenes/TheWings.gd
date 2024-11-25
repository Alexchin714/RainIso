extends Node2D

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.hasDashed = false
	if Input.is_action_pressed("jump"):
		if body.name == "Player":
			body.velocity.y = -1000
			body.move_and_slide(body.velocity)
	$AnimationPlayer.play("Wings")
	$WingTimer.start()
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	
func _on_Timer_timeout():
	pass # Replace with function body.

func _on_WingTimer_timeout():
	$AnimationPlayer.play_backwards("Wings")
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
