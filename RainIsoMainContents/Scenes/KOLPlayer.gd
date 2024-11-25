extends KinematicBody2D

onready var sword: Node2D = get_node("Swords")
onready var bow: Node2D = get_node("Bows")

const UP = Vector2(0, -1)
var GRAVITY = 20
const ACCELERATION = 50
const SPEED = 60
const JUMP_HEIGHT = -200

var ladder_on = false
var motion = Vector2()

func _process(delta):
	if Input.is_action_just_pressed("B"):
		$SwordAnimationPlayer.play("SwordAttack")
		
func _physics_process(delta):
	motion.y += GRAVITY

	if Input.is_action_pressed("d"):
		motion.x = SPEED
		$Sprite.flip_h = false
		sword.scale.x = 1
		$Bows.flip_h = false
		$AnimationPlayer.play("Bruh")
	elif Input.is_action_pressed("a"):
		motion.x = -SPEED
		$Sprite.flip_h = true
		sword.scale.x = -1
		$Bows.flip_h = true
		$AnimationPlayer.play("Bruh")
	else:
		motion.x = 0
		$AnimationPlayer.play("Idle")
		
	if is_on_floor():
		if Input.is_action_just_pressed("A"):
			motion.y = JUMP_HEIGHT
			$AnimationPlayer.play("Bruh")
	
	if ladder_on == true:
		GRAVITY = 0
		if Input.is_action_pressed("w"):
			motion.y = -SPEED
		elif Input.is_action_pressed("s"):
			motion.y = SPEED
		else:
			motion.y = 0
	else:
		GRAVITY = 20
		
	motion = move_and_slide(motion, UP)

func _on_SwordHitbox_body_entered(body):
	pass # Replace with function body.
