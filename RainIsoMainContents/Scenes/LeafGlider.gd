extends KinematicBody2D

export (int) var speed = 0
export (int) var jump_speed = -1000
export (int) var gravity = 0

var velocity = Vector2.ZERO
	
func get_input():
	velocity.x = 0
	if Input.is_action_pressed("d"):
		velocity.x += speed
	if Input.is_action_pressed("a"):
		velocity.x -= speed

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
			
func _on_Area2D_body_exited(body):
	pass

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.glide()
		body.hasDashed = false
	
func _on_Timer_timeout():
	gravity = 10
