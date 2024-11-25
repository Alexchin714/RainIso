extends RigidBody

func _on_Area_body_entered(body):
	$AudioStreamPlayer.play()
	$CollisionShape.call_deferred("disabled", true)
