extends Area2D

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			$KinematicBody2D/AnimationPlayer.play("Coin_Taken")
			yield($KinematicBody2D/AnimationPlayer, "animation_finished")
			queue_free()
		else:
			$KinematicBody2D/AnimationPlayer.play("Coin_Animation")
