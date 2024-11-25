extends KinematicBody2D
class_name Player

enum {
	MOVE,
	WALL_GRAB,
	DEAD
}

export var speed := Vector2(800, 1200)
export var gravity := 4650
export var maxCoyoteTime := 0.3
export var acceleration := 10
export var friction := 10

const floorNormal := Vector2.UP
const dustspawner := preload("res://RainIsoMainContents/Scenes/DustPlayerSpawner.tscn")
const dustrollspawner := preload("res://RainIsoMainContents/Scenes/DustRollPlayerSpawner.tscn")

export(NodePath) var startingRoomPath = ""

onready var ani := get_node("AnimationPlayer")
onready var CameraAnchor: Position2D = $CameraAnchor
onready var checkpoint: Tween = get_node("CheckpointTween")

var _mirror_y_axis_node_original_positions: Dictionary = {}
var last_checkpoint: Area2D = null
var prevRoom = null
var currRoom = null
var velocity := Vector2.ZERO
var axis := Vector2()
var physicsProcesser := true
var state := MOVE
var cayoteTimer: float
var canJump: bool = true
var motionPrevious: = Vector2()
var hitTheGround: = false
var previous_position: = Vector2.ZERO
var check := 0

onready var sprite := $Main/Sprite
onready var animationPlayer := $AnimationPlayer
onready var animationTree := $AnimationTree
onready var dustJumpPosition := $DustPosition
onready var wallChecker := $Main/WallChecker
onready var animationState = animationTree.get("parameters/playback")
onready var jumpSound := $Audio/JumpAudio

func _ready():
	assert(startingRoomPath != '')
	currRoom = get_node(startingRoomPath)
	prevRoom = currRoom
	get_camera().fit_camera_limits_to_room(currRoom)
	for node in get_tree().get_nodes_in_group("mirror_y_axis"):
		_mirror_y_axis_node_original_positions[node] = node.get_position()
	if DataManager.data["Positions"].has(name):
		global_position = DataManager.data["Positions"][name]
		
	if Global.checkpoint == true:
		DataManager.data["Positions"][name] = global_position
		DataManager.saveData()
		Global.checkpoint = false
		
func _physics_process(delta):
	physicProcesser(delta)
	
func physicProcesser(delta):
	match state: 
		MOVE:
			moveState(delta)
		WALL_GRAB:
			wallGrabState(delta)
		DEAD:
			deadState()
				
func moveState(delta) -> void:
	var is_jump_interrupted = Input.is_action_just_released("jump") and velocity.y < 0.0
	if Input.is_action_pressed("climb") && wallChecker.is_colliding():
		state = WALL_GRAB
	if Input.get_action_strength("d"): $Main.scale.x = 1
	elif Input.get_action_strength("a"): $Main.scale.x = -1
	var snap = Vector2.DOWN * 32 if !jump() else Vector2.ZERO
	calculateCayoteTime(delta)
	var direction: = getDirection()
	velocity = calculateMoveVelocity(velocity,direction,speed,is_jump_interrupted)
	motionPrevious = velocity
	velocity = move_and_slide_with_snap(velocity,snap,floorNormal)
	squash(direction,delta)
	
func wallGrabState(delta) -> void:
	sprite.scale = Vector2(1,1)
	animationState.travel("WallJump")
	if !Input.is_action_pressed("jump"):
		state = MOVE
	if wallChecker.is_colliding():
		if Input.is_action_pressed("jump"):
			velocity.y = -1000
			animationState.travel("Climb")
		elif Input.is_action_pressed("sneak"):
			velocity.y = 1000
			animationState.travel("Climb")
		else:
			velocity.y = 0
	else:
		state = MOVE
	velocity = move_and_slide(velocity,floorNormal)
	
func deadState():
	animationState.travel("Dead")

func getDirection()-> Vector2:
	return Vector2(
		Input.get_action_strength("d") - Input.get_action_strength("a"),
		-Input.get_action_strength("jump") if jump() else 0.0)
	
func calculateMoveVelocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
		) -> Vector2:
	var out_velocity: = linear_velocity
	out_velocity.y += gravity * get_physics_process_delta_time() #Gravity
	if direction.x != 0:
		animationTree.set("parameters/Run/blend_position",direction.x)
		animationTree.set("parameters/Idle/blend_position",direction.x)
		animationTree.set("parameters/Fall/blend_position",direction.x)
		animationTree.set("parameters/Jump/blend_position",direction.x)
		animationTree.set("parameters/WallJump/blend_position",direction.x)
		animationTree.set("parameters/WallClimb/blend_position",direction.x)
		animationTree.set("parameters/Dead/blend_position",direction.x)
		animationState.travel("Run")
		out_velocity.x = speed.x * direction.x
	else:
		animationState.travel("Idle")
		out_velocity.x = 0.0

	if direction.y < 0.0:
		out_velocity.y = speed.y * direction.y
		animationState.travel("Jump")
	if direction.y >= 0.0 && not is_on_floor():
		animationState.travel("Fall")
	if is_jump_interrupted:
		out_velocity.y = 0.0
	return out_velocity
	
func calculateCayoteTime(delta) -> void:
	if is_on_floor():
		canJump = true
		cayoteTimer = 0.0
	else:
		cayoteTimer += delta
	if cayoteTimer > maxCoyoteTime:
		canJump = false

func squash(direction,delta) -> void:
	if not is_on_floor():
		hitTheGround = false
		sprite.scale.y = range_lerp(abs(velocity.y), 0, abs(speed.y ), 0.75, 1.75)
		sprite.scale.x = range_lerp(abs(velocity.y), 0, abs(speed.y ), 1.25, 0.75)
	if not hitTheGround and is_on_floor():
		hitTheGround = true
		sprite.scale.x = range_lerp(abs(motionPrevious.y), 0, abs(1700), 1.2, 2.0)
		sprite.scale.y = range_lerp(abs(motionPrevious.y), 0, abs(1700), 0.8, 0.5)
	sprite.scale.x = lerp(sprite.scale.x, 1, 0.25 ) # - pow(0.01, delta)
	sprite.scale.y = lerp(sprite.scale.y, 1, 0.25 )
	
func createJumpDust() -> void:
	var jumpdust = dustspawner.instance()
	get_parent().add_child(jumpdust)
	jumpdust.global_position = dustJumpPosition.global_position
	if dustJumpPosition.position.x > 0:
		jumpdust.change_direction_right()
	elif dustJumpPosition.position.x < 0:
		jumpdust.change_direction_left()
		
func jump() -> bool:
	if Input.is_action_just_pressed("jump") and canJump:
		createJumpDust()
		jumpSound.play()
		return true
	else: return false
	
func get_camera() -> Camera2D:
	return CameraAnchor.get_node("Camera2D") as Camera2D
	
func pause() -> void:
	set_physics_process(false)
	set_process_unhandled_input(false)
	
func unpause() -> void:
	set_physics_process(true)
	set_process_unhandled_input(true)
	
func set_direction(direction: int) -> void:
	if direction in [-1, 1]:
		for node in get_tree().get_nodes_in_group('mirror_y_axis'):
			var original_position = _mirror_y_axis_node_original_positions[node]
			node.position.x = original_position.x * direction
	
func isDead():
	$Audio/SplatAudio.play()
	goToCheckPoint()
	#if health <= 0:
	#	gameOver()
	
func goToCheckPoint():
	checkpoint.interpolate_property(self, "position", position, last_checkpoint.position, 0.2, Tween.TRANS_EXPO, Tween.EASE_OUT)
	checkpoint.start()
	
func dustSpawner():
	var dust = dustspawner.instance()
	
	get_parent().add_child(dust)
	
	dust.position = $DustPosition.global_position
