extends Node2D

	
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.hasDashed = false
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("DashObjectAnimation")
	$DashObjectSFX.play()
	yield(get_tree().create_timer(2), "timeout")
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	$AnimationPlayer.play_backwards("DashObjectAnimation")
