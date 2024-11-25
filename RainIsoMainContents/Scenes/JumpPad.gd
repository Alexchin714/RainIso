extends Node2D

onready var jump_pad_timer = $JumpPadTimer

func _on_JumpPad_body_entered(body):
	if body.name == "Player":
		body.velocity.y = -900
		body.hasDashed = false
		body.move_and_slide(body.velocity)
	$AnimationPlayer.play("JumpPad")
	$SpringSFX.play()
	jump_pad_timer.start()

func _on_JumpPadTimer_timeout():
	$AnimationPlayer.play("JumpPadBack")
