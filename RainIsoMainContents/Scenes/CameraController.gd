extends Spatial

export var distance = 4.0
export var height = 2.0

var player
var distance_from_player : Vector3

var rotSpd = 0
var tiltSpd = 0
var originalCamZoom = null
var originalCamVect = null
var Speed = Vector2()

func _ready():
	

	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	originalCamVect = get_node("Camera").translation.normalized()
	originalCamZoom = get_node("Camera").translation.length()
	get_node("RayCast").add_exception(get_node(".."))

	set_process(true)
	set_process_input(true)
	
func _process(delta):
	
	transform.origin = player.transform.origin - distance_from_player
	
	if Input.is_action_pressed("camw"):
		Speed.y -= 20
	if Input.is_action_pressed("cams"):
		Speed.y += 20
	if Input.is_action_pressed("camd"):
		Speed.x += 20
	if Input.is_action_pressed("cama"):
		Speed.x -= 20
		
	var friction = 0.1

	if abs(rotSpd) > friction:
		rotSpd -= sign(rotSpd) * friction
	else:
		rotSpd = 0

	if abs(tiltSpd) > friction:
		tiltSpd -= sign(tiltSpd) * friction
	else:
		tiltSpd = 0

	rotSpd -= Speed.x * .02
	tiltSpd -= Speed.y * .02

	if Input.get_joy_name(0) != null:
		var camRot = -Input.get_joy_axis(0, 2)
		if abs(camRot) > 0.1:
			rotSpd += camRot * 0.2

		camRot = -Input.get_joy_axis(0, 3)
		if abs(camRot) > 0.1:
			tiltSpd += camRot * 0.2

	var maxRotSpd = 2.5
	var maxTiltSpd = 2.5

	rotSpd = max(min(rotSpd, maxRotSpd), -maxRotSpd)
	tiltSpd = max(min(tiltSpd, maxTiltSpd), -maxTiltSpd)

	var e = rotation

	if e.x > 0.4 and tiltSpd > 0:
		tiltSpd = 0

	if e.x < -1 and tiltSpd < 0:
		tiltSpd = 0

	rotate_y(rotSpd * delta)

	var xLocal = transform.basis.x.normalized()

	rotate(xLocal, tiltSpd * delta)

	var root = get_tree().get_root()
	var toplevel = root.get_child(0)

	if get_parent().get_name() == "Player":
		get_parent().remove_child(self)
		toplevel.add_child(self)

	var target = toplevel.get_node("Player")

	if target != null:
		var tt = target.translation
		tt.y += 2
		translation += (tt - translation) * .05

	var ray = get_node("RayCast")
	var camera = get_node("Camera")
	ray.cast_to = originalCamVect * originalCamZoom

	var dist = camera.translation.length()
	var distTarget = originalCamZoom

	if ray.is_colliding():
		distTarget = (ray.get_collision_point() - translation).length() - 1

	dist += (distTarget - dist) * .1

	camera.translation = originalCamVect.normalized() * dist

	Speed.x = 0
	Speed.y = 0

func _input(event):

	if event is InputEventKey and event.pressed and event.scancode == KEY_F4:

		OS.set_window_maximized(not OS.is_window_maximized())
