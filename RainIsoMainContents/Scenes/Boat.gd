extends KinematicBody

signal health

enum {
	ACTIVE,
	HANGING,
	}

var currentAnim = null
var facing = Vector3(0, 0, -1)

var moveVec = Vector3()
var tiltVec = Vector3()
var analogVec = Vector3()

var canFlash = false
var airAccelRate = 0.25
var maxSpd = 62
var friction = 2
var accelRate = 2 + friction
var gravity = 1.2
var jumpSpd = 26
var coyoteJump = null
var wasOnFloor = false
var state = ACTIVE
var hangingFrom = null
var letGoPosition = Vector3()

func _ready():
	set_physics_process(false)
	coyoteJump = get_node("CoyoteJump")
	
func _physics_process(delta):
	var mv = Vector3()
	var tiltMagnitude = 0
	
	var targetAnim = null
	
	if Input.is_action_pressed("d"):
		mv.x -= 1
	if Input.is_action_pressed("a"):
		mv.x += 1
		
	if Input.is_action_pressed("s"):
		mv.z -= 1
	if Input.is_action_pressed("w"):
		mv.z += 1
		
	tiltMagnitude = mv.length()
		
	if Input.get_joy_name(0) != null and mv.length() == 0:
		
		mv.x = -Input.get_joy_axis(0, 0)
		mv.z = -Input.get_joy_axis(0, 1)
		tiltMagnitude = mv.length()
		
		if tiltMagnitude <= 0.1:
			mv.x = 0
			mv.z = 0
	
	mv = mv.normalized()
	
	var b = Basis(get_viewport().get_camera().global_transform.basis)
	b.z.y = 0 # Crush Y so movement doesn't go into ground
	b.z = b.z.normalized()
	mv = b.xform(mv)
	
	mv.z *= -1
	mv.x *= -1
	
	if mv.length() > 0:
		analogVec = mv
	
	if state == ACTIVE:
				
		if is_on_floor():
			if mv.length() > 0:
					targetAnim = "Run"
			else:
				targetAnim = "Idle"
		else:
			targetAnim = "Jump"
		
		facing += (analogVec.normalized() - facing) * -.25
		facing = facing.normalized()
		facing.y = 0
		get_node("Boat").look_at(translation - facing, Vector3(0, 1, 0) + (tiltVec * -.25))
		
		if is_on_floor():
			var mt = Vector3(moveVec.x, moveVec.y, moveVec.z)
			mt.y = 0
			if mt.length() > friction:
				var frict = moveVec.normalized() * friction
				frict.y = 0
				moveVec -= frict
			else:
				moveVec.x = 0
				moveVec.z = 0
				
			if mv.length() > 0:
				moveVec += mv * accelRate
		elif mv.length() > 0:
			moveVec += mv * airAccelRate
		
		var yspd = moveVec.y
		
		moveVec.y = 0
		
		var mSpd = maxSpd
		
		if is_on_floor():
			mSpd *= tiltMagnitude
		
		if moveVec.length() > mSpd:
			moveVec = moveVec.normalized() * mSpd
		
		moveVec.y = yspd - gravity
		
		if is_on_floor():
			coyoteJump.start()
			letGoPosition = translation
				
		var down = $Boat/LedgeDown
		var forward = $Boat/LedgeFoward
		if down.is_colliding() and forward.is_colliding() and moveVec.y < 0 and not is_on_floor():
			var fallDiff = translation - letGoPosition
			if forward.get_collider() == down.get_collider():
				if forward.get_collision_normal().y <= 0 and down.get_collision_normal().y > 0.5 and fallDiff.length() > 1:
					hangingFrom = forward.get_collider()
					state = HANGING
					translation = forward.get_collision_point() + forward.get_collision_normal() * .5			
					translation.y = down.get_collision_point().y - 2
					$Boat.look_at(translation + forward.get_collision_normal(), Vector3(0, 1, 0))
			
	elif state == HANGING:
		
		if Input.is_action_just_pressed("dash"):
			state = ACTIVE
			letGoPosition = translation
		
		targetAnim = "Hang"
		
		moveVec.x = 0
		moveVec.y = 0
		moveVec.z = 0
		
		if $Boat/LedgeDown.is_colliding() and $Boat/LedgeDown.get_collision_normal().y >= 0.99:
		
			var right = $Boat/LedgeForward.get_collision_normal().cross(Vector3(0, 1, 0))
			
			var vec = Vector3()
			
			if mv.dot(right) > 0.25:
				vec += right
			elif mv.dot(right) < -0.25:
				vec -= right
			
			moveVec += vec * 5
	
	wasOnFloor = is_on_floor()
		
	var prevPos = translation
	
	moveVec = move_and_slide(moveVec, Vector3(0, 1, 0), 0)
	
	if state == HANGING:
		$Boat/LedgeForward.force_raycast_update()
		$Boat/LedgeDown.force_raycast_update()
		if not $Boat/LedgeForward.is_colliding() or $Skeleton/ClementModel/LedgeForward.get_collider() != hangingFrom:
			translation = prevPos
	
	var t = moveVec.normalized()
	if moveVec.length() > 0.01:
		tiltVec += (moveVec.normalized() - tiltVec) * .1
	else:
		tiltVec.x -= tiltVec.x * .1
		tiltVec.y -= tiltVec.y * .1
		tiltVec.z -= tiltVec.z * .1
	
	if translation.y < -100:
		get_tree().reload_current_scene()

func _on_Area_body_entered(body):
	_physics_process(true)

func _on_Area_body_exited(body):
	_physics_process(false)
