extends CanvasLayer

var cutscene = false

func changeToCutscene():
	cutscene = true
	$AnimationPlayer.play("cutscene")

func rollBack():
	cutscene = false
	$AnimationPlayer.play_backwards("cutscene")

func cinematicallyRollBack():
	cutscene = false
	$AnimationPlayer.playback_speed = .25
	$AnimationPlayer.play_backwards("cutscene")
	$Timer.start()

func _on_Timer_timeout():
	$AnimationPlayer.playback_speed = 1
