extends Area2D

signal finish

func _on_Transition_body_entered(body):
	transition()
	emit_signal("finish")

func transition():
	var ani = get_owner().get_node("TransitionCanvas/AnimationPlayer")
	ani.play("transition")
