extends Node2D

signal InteractiveMode
var current_item
var can_place = true

onready var level = get_node("/root/EditorState/Level")
onready var tile_map : TileMap = level.get_node("InteractiveTileMap")

func _process(delta):
	var mousepos = tile_map.world_to_map(get_global_mouse_position())
	
	global_position = get_global_mouse_position()
	
	if !Global.place_interactive_tile:
		if (!Global.filesystem_shown):
			if(current_item != null and can_place and Input.is_action_just_pressed("mb_left")):
				var new_item = current_item.instance()
				level.add_child(new_item)
				new_item.owner = level
				new_item.global_position = get_global_mouse_position()
	if(can_place):
		if Input.is_action_pressed("mb_left"):
			place_tile()
		elif Input.is_action_pressed("delete"):
			var mouse_position = tile_map.world_to_map(get_global_mouse_position())
			remove_tile()
	
func place_tile():
	var square_size = 1
	var mousepos = tile_map.world_to_map(get_global_mouse_position())
	tile_map.set_cell(mousepos.x,mousepos.y,Global.current_tile)
	for x in range(square_size):
		for y in range(square_size):
			tile_map.set_cell(mousepos.x + x,mousepos.y + y,Global.current_tile)

func remove_tile():
	var mousepos = tile_map.world_to_map(get_global_mouse_position())
	tile_map.set_cell(mousepos.x,mousepos.y,-1)

func _on_Editor_Objects_EditMode():
	if !Global.place_interactive_tile:
		if (!Global.filesystem_shown):
			if(current_item != null and can_place and Input.is_action_just_pressed("mb_left")):
				var new_item = current_item.instance()
				level.add_child(new_item)
				new_item.owner = level
				new_item.global_position = get_global_mouse_position()

func _on_ObjectButton_pressed():
	emit_signal("InteractiveMode")
