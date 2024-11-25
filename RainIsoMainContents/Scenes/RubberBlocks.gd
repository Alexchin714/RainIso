extends Spatial

func _on_Area_body_entered(body):
	$AnimationPlayer.play("bounce1")
	if body.name == "Player":
		body.moveVec.y = 60

func _on_Area2_body_entered(body):
	$AnimationPlayer.play("bounce2")
	if body.name == "Player":
		body.moveVec.y = 40
