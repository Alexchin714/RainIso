extends Node2D

var velocity = 0
var force = 0
var height = position.y
var targetHeight = position.y + 80
var a = 0.012
var b = 0.01
var index = 0
var motion_factor = 0.01
var collidedWith = null
signal splash

onready var collision = $Area2D/CollisionShape2D

func waterUpdate(spring, damp):
	height = position.y
	var x = height - targetHeight
	var loss = -damp * velocity
	
	force = -spring * x
	velocity += force
	position.y += velocity
	pass

func _physics_process(delta):
	waterUpdate(a, b)
	
func initial(x_position, id):
	height = position.y
	targetHeight = position
	velocity = 0
	index = id

func setCollisionWidth(value):
	var extents = collision.shape.get_extents()
	var newExtents = Vector2(value/2, extents.y)
	collision.shape.set_extents(newExtents)

func _on_Area2D_body_entered(body):
	
	if body == collidedWith:
		return
		
	collidedWith = body
	
	var speed = body.motion.y * motion_factor
	emit_signal("splash",index,speed)
