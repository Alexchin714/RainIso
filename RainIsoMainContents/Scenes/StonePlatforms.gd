extends KinematicBody2D

export var reset_time : float = 1.0

onready var reset_position = global_position
onready var animation_player = $AnimationPlayer
onready var timer = $ResetTimer

var is_triggered = false
var gravity = 500
var velocity = Vector2()

func _ready():
	set_physics_process(false)
	
func _physics_process(delta):
	velocity.y += gravity * delta
	position += velocity *delta
	
func collide_with(collision: KinematicCollision2D, collider: KinematicBody2D):
	if !is_triggered:
		is_triggered = true
		animation_player.play("ShakeCollision")
		velocity = Vector2.ZERO
		
func _on_AnimationPlayer_animation_finished(anim_name):
	set_physics_process(true)
	timer.start(reset_time)

func _on_ResetTimer_timeout():
	set_physics_process(false)
	yield(get_tree(), "physics_frame")
	var temp = collision_layer
	collision_layer = 0
	global_position = reset_position
	yield(get_tree(), "physics_frame")
	collision_layer = temp
	is_triggered = false
