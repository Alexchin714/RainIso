extends Node2D

func _on_Area2D_body_entered(body):
	$AudioStreamPlayer2D.play()

func _on_Area2D_body_exited(body):
	$AudioStreamPlayer2D.stop()
