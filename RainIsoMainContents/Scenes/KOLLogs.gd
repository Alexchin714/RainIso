extends KinematicBody2D

export var hp_max: int = 20
export var hp: int = hp_max
export var defence: int = 0
 
var is_moving_right = true
var gravity = 2
var velocity = Vector2(0, 0)

var speed = 70
	
func _ready():
	pass
	
func _process(_delta):
	move_character()
	detect_turn_around()
	
func move_character():
	velocity.x = speed if is_moving_right else -speed
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_wall():
		is_moving_right = !is_moving_right
		scale.x = -scale.x
		
func hit():
	$AttackDetector.monitoring = true

func end_of_hit():
	$AttackDetector.monitoring = false

func _on_AttackDetector_body_entered(body):
	get_tree().reload_current_scene()


func _on_Area2D_body_entered(body):
	pass


func _on_HurtBox_body_entered(body):
	queue_free()
