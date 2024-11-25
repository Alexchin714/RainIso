extends Control

func _process(delta):
	if $Panel/Main/RayCast2D.is_colliding() and Input.is_action_just_pressed("dash"):
		$Panel/OutputMain.play("success")
	if !$Panel/Main/RayCast2D.is_colliding() and Input.is_action_just_pressed("dash"):
		$Panel/InputMain.play("input")
