extends KinematicBody

enum {
	ACTIVE,
	HANGING,
	}

var currentAnim = null
var facing = Vector3(0, 0, -1)

var moveVec = Vector3()
var tiltVec = Vector3()
var analogVec = Vector3()

var airAccelRate = 0.25
var maxSpd = 4
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
	if Input.is_action_pressed("dash"):
		maxSpd = 6
	else:
		maxSpd = 4
		
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
	b.z.y = 0
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
		get_node("Skeleton").look_at(translation - facing, Vector3(0, 1, 0) + (tiltVec * -.25))
		
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
				
		var down = $Skeleton/ClementModel/LedgeDown
		var forward = $Skeleton/ClementModel/LedgeForward
		if down.is_colliding() and forward.is_colliding() and moveVec.y < 0 and not is_on_floor():
			var fallDiff = translation - letGoPosition
			if forward.get_collider() == down.get_collider():
				if forward.get_collision_normal().y <= 0 and down.get_collision_normal().y > 0.5 and fallDiff.length() > 1:
					hangingFrom = forward.get_collider()
					state = HANGING
					translation = forward.get_collision_point() + forward.get_collision_normal() * .5			
					translation.y = down.get_collision_point().y - 2
					$Skeleton.look_at(translation + forward.get_collision_normal(), Vector3(0, 1, 0))
			
	elif state == HANGING:
		
		if Input.is_action_just_pressed("dash"):
			state = ACTIVE
			letGoPosition = translation
		
		targetAnim = "Hang"
		
		moveVec.x = 0
		moveVec.y = 0
		moveVec.z = 0
		
		if $Skeleton/ClementModel/LedgeDown.is_colliding() and $Skeleton/Body/LedgeDown.get_collision_normal().y >= 0.99:
		
			var right = $Skeleton/ClementModel/LedgeFoward.get_collision_normal().cross(Vector3(0, 1, 0))
			
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
		$Skeleton/ClementModel/LedgeFoward.force_raycast_update()
		$Skeleton/ClementModel/LedgeDown.force_raycast_update()
		if not $Skeleton/ClementModel/LedgeFoward.is_colliding() or $Skeleton/Body/LedgeFoward.get_collider() != hangingFrom:
			translation = prevPos
	
	var player = $Skeleton/ClementModel/AnimationPlayer
	if not player.is_playing() or currentAnim != targetAnim:
		player.play(targetAnim, 0.1)
		currentAnim = targetAnim
	
	var t = moveVec.normalized()
	if moveVec.length() > 0.01:
		tiltVec += (moveVec.normalized() - tiltVec) * .1
	else:
		tiltVec.x -= tiltVec.x * .1
		tiltVec.y -= tiltVec.y * .1
		tiltVec.z -= tiltVec.z * .1
