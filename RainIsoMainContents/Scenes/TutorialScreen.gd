extends CanvasLayer

var tutorial = false
signal start

func _process(delta):
	if Input.is_action_just_pressed("jump") and tutorial == true:
		emit_signal("start")
		$Container/AnimationPlayer.play_backwards("tutorial")
		tutorial = false
