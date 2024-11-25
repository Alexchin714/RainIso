extends Area2D



func _on_MushroomPad_body_entered(body):
	
	if body.name == "Player":
		body.motion.y = -500
		body.move_and_slide(body.motion)

