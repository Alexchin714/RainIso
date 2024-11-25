extends Node2D

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.isHeating = true
		body.isFreezing = false
		
func _on_Area2D_body_exited(body):
	if body.name == "Player":
		body.isFreezing = true
		body.isHeating = false
