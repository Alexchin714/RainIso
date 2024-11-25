extends RigidBody

func _on_Area_body_entered(body):
	$AudioStreamPlayer.play()
