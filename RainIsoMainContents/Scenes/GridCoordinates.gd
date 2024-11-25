extends Node2D

onready var grid_size = Vector2(get_viewport_rect().size.x,get_viewport_rect().size.y)
var cell_size = 16
var coord = Vector2(0,0)
var pos

func _ready(): set_process_input(true)

func _input(event):
	if (event.is_action_pressed("mouse")):
		var pos
		pos = Vector2(int(get_global_mouse_position().x/cell_size),int(get_global_mouse_position().y/cell_size))
	if pos != coord:
		coord = pos
		print(coord)
