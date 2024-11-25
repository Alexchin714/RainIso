extends CanvasLayer

func skipInfo():
	$AnimationPlayer.play("start")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play_backwards("start")
