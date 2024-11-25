extends Spatial

onready var game = get_parent()
onready var shroom = $CrossShrooms
onready var throom = $TwinsShrooms

const SHROOMS_INACTIVE_POSITION = Vector3(1.124, 0.449, 19.512)
const SHROOMS_ACTIVE_POSITIONS = [Vector3(1.124, 0.449, 19.512), Vector3(1.124, 0.449, 13.967), Vector3(34.571, 0.5, -93.718)]
const TWINS_INACTIVE_POSITION = Vector3(1.124, 0.449, 19.512)
const TWINS_ACTIVE_POSITIONS = [Vector3(1.124, 0.449, 19.512), Vector3(1.124, 0.449, 13.967), Vector3(34.571, 0.5, -93.718)]

var MAX_AI_LEVEL = 10
var ANIMATRONIC_EXTRA_WAIT_TIME_MAX = 5
const SHROOMS_AI = [1]

var shrooms_ai = []

signal exposure_shrooms
signal exposure_twins
signal passed
signal animatronic_movement
signal jumpscare(animatronic)

func _ready():
	randomize()
	set_shroom_to_starting_position()
			
func activate_shroom():
	for attack in range(500):
		for position in SHROOMS_ACTIVE_POSITIONS:
			emit_signal("animatronic_movement")
			shroom.global_transform.origin = position
			
			yield(get_tree().create_timer((MAX_AI_LEVEL + 5) - shrooms_ai[0] + rand_range(0, ANIMATRONIC_EXTRA_WAIT_TIME_MAX)), "timeout")
			if position == SHROOMS_ACTIVE_POSITIONS[-1]:
				MAX_AI_LEVEL -= 2
				ANIMATRONIC_EXTRA_WAIT_TIME_MAX -= 1
				emit_signal("passed")
				$AnimationPlayer.play("shroom")
				yield(get_tree().create_timer(9), "timeout")
				if !game.checked:
					emit_signal("exposure_shrooms")
				$AnimationPlayer.play_backwards("shroom")
				yield(get_tree().create_timer(1), "timeout")

func activate_twins_shroom():
	for attack in range(500):
		for position in TWINS_ACTIVE_POSITIONS:
			emit_signal("animatronic_movement")
			throom.global_transform.origin = position
			
			yield(get_tree().create_timer((MAX_AI_LEVEL + 1) - shrooms_ai[0] + rand_range(0, ANIMATRONIC_EXTRA_WAIT_TIME_MAX)), "timeout")
			if position == TWINS_ACTIVE_POSITIONS[-1]:
				$TwinsStreamPlayer.play()
				MAX_AI_LEVEL -= 2
				ANIMATRONIC_EXTRA_WAIT_TIME_MAX -= 1
				emit_signal("passed")
				yield(get_tree().create_timer(9), "timeout")
				if !game.seal:
					emit_signal("exposure_twins")
				$TwinsMetal.play()
				yield(get_tree().create_timer(1), "timeout")
				
func set_shroom_to_starting_position():
	shroom.global_transform.origin = SHROOMS_INACTIVE_POSITION
	throom.global_transform.origin = TWINS_INACTIVE_POSITION
