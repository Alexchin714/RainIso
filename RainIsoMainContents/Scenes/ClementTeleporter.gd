extends Area2D

func _on_Teleporter_body_entered(body):
	var player = get_owner().get_node("TopDownPlayer")
	var positions = get_owner().get_node("Position2D")
	yield(get_tree().create_timer(.2), "timeout")
	player.position = positions.position
