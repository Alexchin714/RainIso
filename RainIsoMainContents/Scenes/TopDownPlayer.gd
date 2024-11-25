extends KinematicBody2D

var horizontal_input
var vertical_input
var direction = Vector2()

var horizontal_speed
var vertical_speed
var speed = Vector2()

var velocity = Vector2()
var delta_velocity = Vector2()

var max_speed = 24
var speed_multiplier = 1000
var true_max_speed = max_speed * speed_multiplier

const ACCEL_WEIGHT = .3

func _ready():
	horizontal_input = 0
	vertical_input = 0
	
	horizontal_speed = 0;
	vertical_speed = 0;
	pass

func _physics_process(delta):
	var is_moving = Input.is_action_pressed("w") or Input.is_action_pressed("d") or Input.is_action_pressed("s") or Input.is_action_pressed("a")
	
	if Input.is_action_pressed("w"):
		$AnimationPlayer.play("Back")
	if Input.is_action_pressed("s"):
		$AnimationPlayer.play("Front")
	if Input.is_action_pressed("a"):
		$AnimationPlayer.play("Left")
	if Input.is_action_pressed("d"):
		$AnimationPlayer.play("Right")
	if is_moving:
		horizontal_input = int(Input.is_action_pressed("d")) - int(Input.is_action_pressed("a"))
		vertical_input = int(Input.is_action_pressed("s")) - int(Input.is_action_pressed("w"))
		
		horizontal_speed = lerp(horizontal_speed, abs(horizontal_input), ACCEL_WEIGHT)
		vertical_speed = lerp(vertical_speed, abs(vertical_input), ACCEL_WEIGHT)
	else:
		$AnimationPlayer.stop()
		horizontal_speed = lerp(horizontal_speed, 0, ACCEL_WEIGHT)
		vertical_speed = lerp(vertical_speed, 0, ACCEL_WEIGHT)
			
	direction = Vector2(horizontal_input, vertical_input).normalized()
	speed = Vector2(horizontal_speed, vertical_speed)
	
	velocity = direction * speed
	delta_velocity = true_max_speed * velocity * delta
	
	move_and_slide(delta_velocity)
	pass
