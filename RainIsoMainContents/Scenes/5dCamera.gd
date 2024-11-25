extends Camera

onready var cam = self
var rotation_speed = PI/2

func get_input_keyboard(delta):
	var y_rotation = 0
	if Input.is_action_pressed("cama"):
		y_rotation += 1
	if Input.is_action_pressed("camd"):
		y_rotation -= 1
	rotate_object_local(Vector3.UP, y_rotation * rotation_speed * delta)
	var x_rotation = 0
	self.rotate_object_local(Vector3.RIGHT, x_rotation * rotation_speed * delta)

func _process(delta):
	get_input_keyboard(delta)
