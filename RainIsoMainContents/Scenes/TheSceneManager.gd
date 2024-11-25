extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		$TransitionFade.transition()


func _on_TransitionFade_transitioned():
	pass # Replace with function body.
