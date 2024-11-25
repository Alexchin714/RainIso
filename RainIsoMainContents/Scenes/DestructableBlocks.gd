extends KinematicBody

var hp = 1

func _physics_process(delta):
	if hp < 0:
		$AnimationPlayer.play("des")
		set_physics_process(false)
