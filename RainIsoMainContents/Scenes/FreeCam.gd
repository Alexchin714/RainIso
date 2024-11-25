extends Camera2D

onready var camera = get_owner().get_node("CameraAnchor/Camera2D")

var speed = 30
var velocity = Vector2.ZERO
var toggle = false

func _process(delta):
	freeCam()
	if toggle == true:
		self.current = true
		camera.current = false
		move()
	if toggle == false:
		self.current = false
		camera.current = true
		
func freeCam():
	if Input.is_action_just_pressed("toggle_freecam"):
		toggle = !toggle
	
func move():
	if Input.is_action_pressed("d"):
		velocity.x += 1
	if Input.is_action_pressed("a"):
		velocity.x -= 1
	if Input.is_action_pressed("s"):
		velocity.y += 1
	if Input.is_action_pressed("w"):
		velocity.y -= 1
