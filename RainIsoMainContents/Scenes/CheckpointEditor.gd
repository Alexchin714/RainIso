extends Area2D
	
func _on_CheckpointEditor_body_entered(body: Node):
	$AnimationPlayer.play("MushroomAni")
	if body.name == "Player":
		Room.update_spawn(self.global_position)
