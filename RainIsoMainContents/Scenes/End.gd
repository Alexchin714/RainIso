extends Area2D

signal EndOption
var trigger = false

func _on_End_body_entered(body):
	emit_signal("EndOption")
	
func _on_End_body_exited(body):
	pass
