extends CanvasLayer

onready var timer = $TheMainer/Timer

func _on_Area2D_body_entered(body):
	$TheMainer/AnimationPlayer.play("TheAmulet")
	timer.start()
	
func _on_Timer_timeout():
	$TheMainer/AnimationPlayer.play_backwards("TheAmulet")
