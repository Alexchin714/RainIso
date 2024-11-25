extends Node2D

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.can_dash = true
	$AnimationPlayer.play("Magneto")
	$Timer.start()
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	
func _on_Timer_timeout():
	$AnimationPlayer.play_backwards("Magneto")
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
