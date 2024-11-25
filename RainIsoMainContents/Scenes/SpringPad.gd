extends Node2D

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.velocity.y = -900
		body.hasDashed = false
		body.move_and_slide(body.velocity)
	$AnimationPlayer.play("SpringJump")
