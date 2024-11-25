extends Spatial

func _on_Area_body_entered(body):
	if body.name == "Player" or body.name == "3dPlayer":
		body.moveVec.y = 50
