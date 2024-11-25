extends Node2D

var velocity = 0

var force = 0

var height = position.y

var target_height = position.y + 80

var d = 0.03
var k = 0.015

func water_update(spring_constant, dampening):
	var x = height - target_height
	var loss = -dampening * velocity
	height = position.y
	force = - spring_constant * x + loss
	velocity += force
	position.y += velocity

func _physics_process(delta):
	water_update(k,d)
	
func initialize(x_position):
	height = position.y
	target_height = position.y
	velocity = 0
	position.x = x_position
