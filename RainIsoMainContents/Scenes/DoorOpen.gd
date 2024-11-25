extends Spatial

func door_open():
	$AnimationPlayer.play("dooropen")
	$AudioStreamPlayer.play()
