extends CanvasLayer

func playEffect():
	$AnimationPlayer.play("screen")
	yield($AnimationPlayer,'animation_finished')
	$AnimationPlayer.play_backwards("screen")
