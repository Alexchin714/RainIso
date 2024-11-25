extends Node2D

var current_item
var can_place = true
onready var level = get_node("/root/Editor/Level")

onready var tile_map : TileMap = level.get_node("TileMapDeselect")

func _process(delta):
	global_position = get_global_mouse_position()
	
	if !Global.place_tile:
		if (!Global.filesystem_shown):
			if(current_item != null and can_place and Input.is_action_just_pressed("mb_left")):
				var new_item = current_item.instance()
				level.add_child(new_item)
				new_item.owner = level
				new_item.global_position = get_global_mouse_position()
	else:
		if (!Global.filesystem_shown):
			if(can_place):
				if Input.is_action_pressed("mb_left"):
					place_tile()
				if Input.is_action_pressed("delete"):
					remove_tile()
					
func place_tile():
	var square_size = 1
	var mousepos = tile_map.world_to_map(get_global_mouse_position())
	tile_map.set_cell(mousepos.x,mousepos.y,Global.current_tile)
	DataManager.data["Objects"][name] = global_position
	DataManager.save_data()
	
func remove_tile():
	var mousepos = tile_map.world_to_map(get_global_mouse_position())
	tile_map.set_cell(mousepos.x,mousepos.y,-1)
