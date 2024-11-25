extends Area2D

func _on_ExtendedCameraBy2_body_entered(body):
	if body.name == "TransitionalCamera2D":
		body.SCREEN_SIZE = Vector2( 2560, 1440 )
