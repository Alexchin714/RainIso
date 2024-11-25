extends Area

func _on_Area_body_entered(body):
	$AnimationPlayer.play("doorani")
