extends StaticBody2D

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.hasDashed = false
		body.velocity.y = -250
		body.velocity.x = 10
		body.move_and_slide(body.velocity)
	$AnimationPlayer.play("Logged")

func _on_Area2D_body_exited(body):
	$AnimationPlayer.play_backwards("Logged")
