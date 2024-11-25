extends KinematicBody2D

var isOnTurningLeft = false
var isOnTurningUp = true

var velocity = Vector2(0, 0)
var speed = 400000
var gravity = 50

func _physics_process(delta):
	var collisionInfo = move_and_slide(velocity.normalized() * delta * speed)
	
	velocity.y += gravity
	
	if isOnTurningLeft:
		speed = -speed

func _on_Timer_timeout():
	pass # Replace with function body.
