extends KinematicBody2D

var is_triggered = false
var gravity = 200
var velocity = Vector2()

func _ready():
	set_physics_process(false)
	
func _physics_process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	
func collide_with(collision: KinematicCollision2D, collider: KinematicBody2D):
	if !is_triggered:
		is_triggered = true
		$AnimationPlayer.play("FallShake")
		velocity = Vector2.ZERO

func _on_AnimationPlayer_animation_finished(anim_name):
	set_physics_process(true)
