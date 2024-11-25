extends Area2D

func _on_TeleporterBack_body_entered(body):
	var player = get_owner().get_node("TopDownPlayer")
	var positions = get_owner().get_node("Position2D2")
	player.position = positions.position
