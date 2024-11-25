extends KinematicBody2D

var velocity = Vector2(0, 0)
var speed = 80000

func _physics_process(delta):
	var collisionInfo = move_and_slide(velocity.normalized() * delta * speed)
