extends Node2D

var can_place = true
var is_panning = true;

var do_save = false;

var current_shape := 0

enum BrushShape { CIRCLE, SQUARE }

onready var tileoffset = 1
onready var tilesprite = $Sprite
onready var level = get_node("/root/EditorState/Level")
onready var editor = get_node("/root/EditorState/CamContainer")
onready var editor_cam = editor.get_node("Camera2D")
onready var cursor = $Sprite

onready var circlebutton: Button = get_node("/root/EditorState/EditorSpace/Control/CircleButton")
onready var squarebutton: Button = get_node("/root/EditorState/EditorSpace/Control/SquareButton")

onready var editorspacecontrol = get_node("/root/EditorState/EditorSpace/Control")
onready var brushlabel = get_node("/root/EditorState/ItemSelectionScreen/BrushSize/Label2")
onready var editor_space = get_node("/root/EditorState/EditorSpace")
onready var interactive_tile_map : TileMap = level.get_node("StaticBody2D/InteractiveTileMap")
onready var tile_mapdeco : TileMap = level.get_node("StaticBody2D/TileMapSecond")
onready var tile_mapspike : TileMap = level.get_node("StaticBody2D/Area2D/TileMapFourth")
onready var player : KinematicBody2D = level.get_node("Player")
onready var brush_slider = get_node("/root/EditorState/ItemSelectionScreen/BrushSize/HSlider")

onready var popup : FileDialog = get_node("/root/EditorState/ItemSelectionScreen/FileDialog")

onready var brush_size = 1
export var cam_spd = 10
var current_item

const CURSOR := preload("res://RainIsoMainContents/Scenes/Cursor.tscn")

func _ready():
	editor_cam.current = true
	set_new_cursor_shape()
	pass # Replace with function body.

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
		#var tilePos #= tile_map.world_to_map(get_global_mouse_position())
		#tilesprite.global_position = Vector2(tilePos.x * Global.tile_size-tileoffset * brush_size)
		#tilesprite.set_scale(Vector2(brush_size,brush_size))
		if(can_place):
			if Input.is_action_pressed("mb_left"):
				#var mouse_position = tile_map.world_to_map(get_global_mouse_position())
				#for i in range(0,brush_size):
					#for j in range(0,brush_size):
				place_tile()
			elif Input.is_action_pressed("delete"):
				#var mouse_position = interactive_tile_map.world_to_map(get_global_mouse_position())
				for i in range(0,brush_size):
					for j in range(0,brush_size):
						remove_tile()
						
	move_editor()
	is_panning = Input.is_action_pressed("mb_middle")
		
	if Input.is_action_pressed("save"):
		Global.filesystem_shown = true
		do_save = true
		popup.mode = 4
		popup.show()
	if Input.is_action_pressed("load"):
		Global.filesystem_shown = true
		do_save = true
		popup.mode = 0
		popup.show()
	pass
	
func place_tile():
	var square_size = 1
	square_size = brush_size
	#var mousepos = interactive_tile_map.world_to_map(get_global_mouse_position())
	#interactive_tile_map.update_bitmask_region(mousepos + Vector2(-2,-2), mousepos + Vector2(2, 2))
	#interactive_tile_map.set_cell(mousepos.x,mousepos.y,Global.current_tile)
	#interactive_tile_map.set_cell(mousepos.x,mousepos.y,Global.current_tile)
	#for x in range(square_size):
	#	for y in range(square_size):
			#interactive_tile_map.set_cell(mousepos.x + x,mousepos.y + y,Global.current_tile)
	#DataManager.data["Objects"][name] = global_position
	#DataManager.save_data()
	
func remove_tile():
	#var mousepos = interactive_tile_map.world_to_map(get_global_mouse_position())
	#interactive_tile_map.update_bitmask_region(mousepos + Vector2(-2,-2), mousepos + Vector2(2, 2))
	#interactive_tile_map.set_cell(mousepos.x,mousepos.y,-1)
	pass
	
func move_editor():
	if Input.is_action_pressed("EditorUp"):
		editor.global_position.y -= cam_spd
	if Input.is_action_pressed("EditorLeft"):
		editor.global_position.x -= cam_spd
	if Input.is_action_pressed("EditorDown"):
		editor.global_position.y += cam_spd
	if Input.is_action_pressed("EditorRight"):
		editor.global_position.x += cam_spd
		
func _unhandled_input(event):
	if(event is InputEventMouseButton):
		if(event.is_pressed()):
			if(event.button_index == BUTTON_WHEEL_UP):
				editor_cam.zoom -= Vector2(0.1,0.1)
			if(event.button_index == BUTTON_WHEEL_DOWN):
				editor_cam.zoom += Vector2(0.1,0.1)
	if(event is InputEventMouseMotion):
		if(is_panning):
			editor.global_position -= event.relative * editor_cam.zoom
			
func set_new_cursor_shape() -> void:
	match current_shape:
		BrushShape.CIRCLE:
			var half_size := int(floor(brush_size * 0.5))
			for x in range(-half_size, half_size + 1):
				for y in range(-half_size, half_size + 1):
					if pow(x, 2) + pow(y, 2) <= pow(half_size, 2):
						var c: Sprite = CURSOR.instance()
						c.offset_pos = 16 * 4 * Vector2(x, y)
		BrushShape.SQUARE:
			var half_size := int(floor(brush_size * 0.5))
			for x in range(-half_size, half_size + 1):
				for y in range(-half_size, half_size + 1):
					var c: Sprite = CURSOR.instance()
					c.offset_pos = 16 * 4 * Vector2(x, y)
		_:
			pass
			
func save_level():
	var toSave : PackedScene = PackedScene.new()
	interactive_tile_map.owner = level
	toSave.pack(level)
	ResourceSaver.save(popup.current_path,toSave)

func load_level():
	var toLoad : PackedScene = PackedScene.new()
	toLoad = ResourceLoader.load(popup.current_path)
	var this_level = toLoad.instance()
	get_parent().remove_child(level)
	level.queue_free()
	get_parent().add_child(this_level)
	interactive_tile_map = get_parent().get_node("Level/StaticBody2D/TileMap")
	level = this_level

func _on_FileDialog_confirmed():
	if popup.window_title == "Save a File":
		save_level()
	else:
		load_level()
	pass 


func _on_FileDialog_hide():
	Global.filesystem_shown = false
	do_save = false
	pass
