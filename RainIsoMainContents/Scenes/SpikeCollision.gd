extends Area2D
signal collision
signal nocollision


func _on_Area2D_body_entered(body):
	if body.get("TYPE") == "player":
		emit_signal("collision")
		pass

func _on_Area2D_body_exited(body):
	if body.get("TYPE") == "player":
		emit_signal("nocollision")
		pass
