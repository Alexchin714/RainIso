extends Node

const TILE_SIZE: int = 32

const FLOOR_NORMAL: Vector2 = Vector2.UP

# Constants passed as the snap value to move_and_slide_with_snap().
const SNAP: Vector2 = 10.0 * Vector2.DOWN
const NO_SNAP: Vector2 = Vector2.ZERO

enum Direction {
	LEFT = -1,
	NONE = 0,
	RIGHT = 1,
}

const _LAYER_NAMES := {
	'Ground': 0,
	'Player': 1,
	'Hook': 2,
	'Interactable': 3,
	'Bounce': 4,
	'Walls': 5,
	'EnemyHurtbox': 6,
	'Room': 7,
	'Cam': 8,
}

func _ready():
	var i := 1
	for layer_name in _LAYER_NAMES:
		var layer_path := str('layer_names/2d_physics/layer_', i)

		assert(_LAYER_NAMES[layer_name] == i-1)
		assert(ProjectSettings.get_setting(layer_path) == layer_name)

		i += 1
		
func get_input_direction() -> int:
	return int(Input.is_action_pressed("d")) - \
		   int(Input.is_action_pressed("a"))

func get_ingame_resolution() -> Vector2:
	var w = ProjectSettings.get_setting('display/window/size/width')
	var h = ProjectSettings.get_setting('display/window/size/height')

	return Vector2(w, h)
	
func direction(from: Node2D, to: Node2D) -> int:
	return int(sign((to.global_position - from.global_position).x))

func in_collision_layer(collision_object, layer_names: Array) -> bool:
	assert(collision_object.has_method('get_collision_layer_bit'))
	for layer_name in layer_names:
		assert(layer_name in _LAYER_NAMES)
		if collision_object.get_collision_layer_bit(_LAYER_NAMES[layer_name]):
			return true
	return false
