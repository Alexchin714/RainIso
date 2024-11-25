extends Spatial

func _on_Area_body_entered(body):
	$AnimationPlayer.play("Fall")
	$Timer.start()
	
func _on_Timer_timeout():
	$AnimationPlayer.play("Elevate")
	$Area/CollisionShape.set_deferred("disabled", false)
