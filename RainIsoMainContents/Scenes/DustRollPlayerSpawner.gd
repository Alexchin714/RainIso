extends Sprite

func _on_Timer_timeout():
	$AnimationPlayer.play("dust")
	
func queue():
	queue_free()
