extends Camera2D

signal transition_completed

onready var _player: Player = get_parent().get_parent()
onready var _tween: Tween = $PositionTween

var _original_local_anchor_pos = 0
export var decay = 0.4
export var max_offset = Vector2(25, 25)
export var max_roll = 0.3
export (NodePath) var target

var can_shake = false

var trauma = 0.0  
var trauma_power = 1.25

onready var noise = OpenSimplexNoise.new()
var noise_y = 0

func _ready():
	GlobalSettings.connect("screenshake", self, "canShake")
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2

func add_trauma(amount):
	trauma = min(trauma + amount, 0.25)
	
func _process(delta):
	if target:
		global_position = get_node(target).global_position
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		#shake()

func shake():
	if !can_shake:
		var amount = pow(trauma, trauma_power)
		noise_y += 1
		rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
		offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
		offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)
	
func canShake(value):
	can_shake = value
	
func transition(old_room, new_room) -> void:
	_transition_setup()

	var old_global_pos = old_room.get_closest_camera_anchor(_player)
	var new_global_pos = new_room.get_closest_camera_anchor(_player)
	_interpolate_camera_pos(old_global_pos, new_global_pos)

	yield(_tween, 'tween_started')
	_remove_camera_limits()

	yield(_tween, 'tween_completed')
	_transition_teardown(new_room)

	emit_signal('transition_completed')

func fit_camera_limits_to_room(room: Room2D) -> void:
	var room_dims := room.get_room_dimensions()

	self.limit_left = room.global_position.x
	self.limit_right = room.global_position.x + room_dims.x
	self.limit_top = room.global_position.y
	self.limit_bottom = room.global_position.y + room_dims.y

func _transition_setup() -> void:
	_player.pause()

	_original_local_anchor_pos = self.position

	self.smoothing_enabled = false

func _transition_teardown(room: Room2D) -> void:
	self.position = _original_local_anchor_pos

	self.fit_camera_limits_to_room(room)

	self.smoothing_enabled = true

	_player.unpause()

func _interpolate_camera_pos(old_global_pos, new_global_pos) -> void:
	var prop := "position"
	var duration := 0.2
	var trans := Tween.TRANS_QUAD
	var easing := Tween.EASE_IN_OUT

	var old := self.to_local(old_global_pos)
	var new := self.to_local(new_global_pos)

	_tween.stop_all()
	_tween.interpolate_property(self, prop, old, new, duration, trans, easing)
	_tween.start()

func _remove_camera_limits() -> void:
	self.limit_left = -10000000
	self.limit_right = 10000000
	self.limit_top = -10000000
	self.limit_bottom = 10000000
