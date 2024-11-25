extends KinematicBody

var hp = 48

func _physics_process(delta):
	if hp < 0:
		$AnimationPlayer.play("dead")
		set_physics_process(false)
