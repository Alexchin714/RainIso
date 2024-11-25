extends Node2D

var shop = false

func _process(delta):
	if shop == true and Input.is_action_just_pressed("jump"):
		pass
		
func _on_Area2D_body_entered(body):
	shop = true

func _on_Area2D_body_exited(body):
	shop = false

func openShop():
	pass
