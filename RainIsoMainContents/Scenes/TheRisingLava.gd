extends Node2D

func _on_Area2D_body_entered(body):
	visible = true
	$AnimationPlayer.play("TheRise")
