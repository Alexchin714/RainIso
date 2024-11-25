extends KinematicBody

signal coin_collected

export var view = 0

export var movement_speed = 250
export var jump_strength = 7

var velocity = Vector3.ZERO
var movement_velocity: Vector3
var rotation_direction: float
var gravity = 0

var previously_floored = false

var jump_single = true
var jump_double = true

var coins = 0

onready var particles_trail = $ParticlesTrail
onready var sound_footsteps = $SoundFootsteps
onready var model = $Character
onready var animation = $Character/AnimationPlayer

func _physics_process(delta):
	handle_controls(delta)
	handle_gravity(delta)
	
	handle_effects(delta)

	var applied_velocity: Vector3
	
	applied_velocity = velocity.lerp(movement_velocity, delta * 10)
	applied_velocity.y = -gravity
	
	velocity = applied_velocity
	move_and_slide(velocity, Vector3.UP)
	
	if Vector2(velocity.z, velocity.x).length() > 0:
		rotation_direction = Vector2(velocity.z, velocity.x).angle()
		
	rotation.y = lerp_angle(rotation.y, rotation_direction, delta * 10)
	
	if self.position.y < -10:
		get_tree().reload_current_scene()
	
	model.scale = model.scale.lerp(Vector3(1, 1, 1), delta * 10)

	if is_on_floor() and gravity > 2 and !previously_floored:
		model.scale = Vector3(1.25, 0.75, 1.25)
	
	previously_floored = is_on_floor()

func handle_effects(delta):
	
	particles_trail.emitting = false
	sound_footsteps.stream_paused = true
	
	if is_on_floor():
		var horizontal_velocity = Vector2(velocity.x, velocity.z)
		var speed_factor = horizontal_velocity.length() / movement_speed / delta
		if speed_factor > 0.05:
			animation.play("walk", 0, speed_factor)
				
			if speed_factor > 0.3:
				sound_footsteps.stream_paused = false
				sound_footsteps.pitch_scale = speed_factor
				
			if speed_factor > 0.75:
				particles_trail.emitting = true
				
		else:
			animation.play("idle", 0)
	else:
		animation.play("jump", 0)

func handle_controls(delta):
	var input := Vector3.ZERO
	
	input.x = Input.set_action("a", "d")
	input.z = Input.get_axis("w", "s")
	
	input = input.rotated(Vector3.UP, view.rotation.y)
	
	if input.length() > 1:
		input = input.normalized()
		
	movement_velocity = input * movement_speed * delta
	
	if Input.is_action_just_pressed("jump"):
		
		if jump_single or jump_double:
			jump()

func handle_gravity(delta):
	
	gravity += 25 * delta
	
	if gravity > 0 and is_on_floor():
		
		jump_single = true
		gravity = 0

func jump():
	
	gravity = -jump_strength
	
	model.scale = Vector3(0.5, 1.5, 0.5)
	
	if jump_single:
		jump_single = false;
		jump_double = true;
	else:
		jump_double = false;

func collect_coin():
	
	coins += 1
	
	emit_signal("coin_collected")
