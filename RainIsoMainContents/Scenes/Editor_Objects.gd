extends Node2D

signal EditMode
var can_place = true
var is_panning = true;

var do_save = false;

var current_shape := 0

enum BrushShape { CIRCLE, SQUARE }

onready var tileoffset = 1
onready var tilesprite = $Sprite
onready var level = get_node("/root/EditorState/Level")
onready var editor = get_owner().get_node("CamContainer")
onready var editor_cam = editor.get_node("Camera2D")
onready var cursor = $Sprite

onready var circlebutton: Button = get_node("/root/EditorState/EditorSpace/Control/CircleButton")
onready var squarebutton: Button = get_node("/root/EditorState/EditorSpace/Control/SquareButton")

onready var editorspacecontrol = get_node("/root/EditorState/EditorSpace/Control")
onready var brushlabel = get_node("/root/EditorState/ItemSelectionScreen/BrushSize/Label2")
onready var editor_space = get_node("/root/EditorState/EditorSpace")
onready var tile_map : TileMap = level.get_node("StaticBody2D/TileMap")
onready var interactive_tile_map : TileMap = level.get_node("StaticBody2D/InteractiveTileMap")
onready var tile_mapdeco : TileMap = level.get_node("StaticBody2D/TileMapSecond")
onready var tile_mapspike : TileMap = level.get_node("StaticBody2D/Area2D/TileMapFourth")
onready var player : KinematicBody2D = level.get_node("Player")
onready var brush_slider = get_node("/root/EditorState/ItemSelectionScreen/BrushSize/HSlider")

onready var sfx01 = get_parent().get_node("SFX/ZoomInOut")
onready var sfx02 = get_parent().get_node("SFX/PauseSpace")
onready var sfx03 = get_parent().get_node("SFX/PauseSpacePress")
onready var sfx04 = get_parent().get_node("SFX/ZoomPress")
onready var sfx05 = get_parent().get_node("SFX/PopPlace")
onready var sfx06 = get_parent().get_node("SFX/Clapper")
onready var sfx07 = get_parent().get_node("SFX/ClapperHover")
onready var sfx08 = get_parent().get_node("SFX/DiscHover")
onready var sfx09 = get_parent().get_node("SFX/StyleHover")
onready var sfx10 = get_parent().get_node("SFX/Pop")
onready var sfx11 = get_parent().get_node("SFX/StyleSine")

onready var editorSpaceAni = get_parent().get_node("EditorSpace/Control/AnimationPlayer")
onready var popup : FileDialog = get_node("/root/EditorState/ItemSelectionScreen/FileDialog")

onready var brush_size = 1
export var cam_spd = 10
var current_item

var doList = []
var doPointer = -1

const CURSOR := preload("res://RainIsoMainContents/Scenes/Cursor.tscn")

func _ready():
	editor_cam.current = true
	set_new_cursor_shape()
	pass # Replace with function body.

func _process(delta):
	var mousepos = tile_map.world_to_map(get_global_mouse_position())
	
	global_position = get_global_mouse_position()

	if Input.is_action_pressed("altUndo"):
		Undo()
		
	elif Input.is_action_pressed("altRedo"):
		Redo()

	if Input.is_action_just_pressed("undo"):
		Undo()
 
	elif Input.is_action_just_pressed("redo"):
		Redo()
		
	if current_item != null and can_place and Input.is_action_just_pressed("mb_left"):
		Action_PlaceInstance(get_global_mouse_position(), current_item)
 
	else:
		if can_place:
			var mouse_pos = tile_map.world_to_map(get_global_mouse_position())
			if Input.is_action_pressed("mb_left"):
				Action_PlaceTile(mouse_pos, Global.current_tile)
			if Input.is_action_pressed("mb_right"):
				Action_PlaceTile(mouse_pos, -1)
		if Input.is_action_just_released("mb_left"):
			tile_map.update_bitmask_region(mousepos + Vector2(-64,-64), mousepos + Vector2(64, 64))
						
	move_editor()
	is_panning = Input.is_action_pressed("mb_middle")
		
	if Input.is_action_pressed("save"):
		get_tree().paused = true
		Global.filesystem_shown = true
		do_save = true
		popup.mode = 4
		popup.show()
	if Input.is_action_pressed("load"):
		get_tree().paused = true
		Global.filesystem_shown = true
		do_save = true
		popup.mode = 0
		popup.show()
		
	if editor_cam.zoom.x > 2 and editor_cam.zoom.y > 2:
		editor_cam.zoom -= Vector2(0.1,0.1)
	pass
	
func Undo():
	if !doList.empty() and doPointer >= 0:
		var actionDict = doList[doPointer]
		match actionDict["action"]:
			"PlaceTile":
				place_tile(actionDict["undoVector"], actionDict["undoIndex"])
			"PlaceInstance":
				erase_object(actionDict["undoId"])
		doPointer -= 1
 
func Redo():
	if !doList.empty() and doPointer < doList.size() -1:
		var actionDict = doList[doPointer]
		match actionDict["action"]:
			"PlaceTile":
				place_tile(actionDict["redoVector"], actionDict["redoIndex"])
			"PlaceInstance":
				var new_item = place_object(actionDict["redoVector"], actionDict["redoObject"])
				actionDict["undoId"] = new_item
		doPointer += 1
 
func NewEndOfDoList():
	if (doPointer +1) != doList.size():
		doList.resize(doPointer +1)
 
func Action_PlaceTile(pos, tileIndex):
	var whatsAtTheTileNow = tile_map.get_cell(pos.x, pos.y)
	if whatsAtTheTileNow != tileIndex:
		NewEndOfDoList()
		#create dictionary for doList
		var placeTileDict = {
			"action" : "PlaceTile",
			"redoIndex" : tileIndex,
			"redoVector" : pos,
			"undoIndex" : whatsAtTheTileNow,
			"undoVector" : pos,
			}
		doList.append(placeTileDict)
		doPointer += 1
		place_tile(pos, tileIndex)
		
func place_tile(pos, tile_index):
	tile_map.set_cell(pos.x, pos.y, tile_index)
	tile_map.update_bitmask_region(pos + Vector2(-2,-2), pos + Vector2(2, 2))
 
func Action_PlaceInstance(pos, object):
	NewEndOfDoList()
	#create dictionary for doList
	var new_item = place_object(pos, object)
	var placeInstanceDict = {
		"action" : "PlaceInstance",
		"redoObject" : object,
		"redoVector" : pos,
		"undoId" : new_item,
		}
	doList.append(placeInstanceDict)
	doPointer += 1
 
func Action_RemoveInstance():
	#do it like Action_PlaceInstance but in reverse.
	#don't forget to update _process!
	#maybe also move the now quite large "if !Global.place_tile:" section
	#into it's own function? call it handle_mouse_input() or something 
	#like that.
	pass
 
func place_object(pos, object):
	var new_item = object.instance()
	level.add_child(new_item)
	new_item.owner = level
	new_item.global_position = pos
	return new_item
 
func erase_object(id):
	id.queue_free()
	
func remove_tile():
	var mousepos = tile_map.world_to_map(get_global_mouse_position())
	#var interactive_mousepos = interactive_tile_map.world_to_map(get_global_mouse_position())
	tile_map.update_bitmask_region(mousepos + Vector2(-16,-16), mousepos + Vector2(16, 16))
	tile_map.set_cell(mousepos.x,mousepos.y,-1)
	#interactive_tile_map.set_cell(mousepos.x,mousepos.y,-1)
	
func move_editor():
	if Input.is_action_pressed("w"):
		editor.global_position.y -= cam_spd
	if Input.is_action_pressed("a"):
		editor.global_position.x -= cam_spd
	if Input.is_action_pressed("s"):
		editor.global_position.y += cam_spd
	if Input.is_action_pressed("d"):
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
	tile_map.owner = level
	toSave.pack(level)
	ResourceSaver.save(popup.current_path,toSave)

func load_level():
	var toLoad : PackedScene = PackedScene.new()
	toLoad = ResourceLoader.load(popup.current_path)
	var this_level = toLoad.instance()
	get_parent().remove_child(level)
	level.queue_free()
	get_parent().add_child(this_level)
	tile_map = get_parent().get_node("Level/StaticBody2D/TileMap")
	level = this_level

func _on_FileDialog_confirmed():
	get_tree().paused = false
	if popup.window_title == "Save a File":
		save_level()
	else:
		load_level()
	pass 

func _on_FileDialog_hide():
	get_tree().paused = false
	Global.filesystem_shown = false
	do_save = false
	pass

func _on_Ground_tab_changed(tab):
	if !Global.place_tile:
		if (!Global.filesystem_shown):
			if(current_item != null and can_place and Input.is_action_just_pressed("mb_left")):
				var new_item = current_item.instance()
				level.add_child(new_item)
				new_item.owner = level
				new_item.global_position = get_global_mouse_position()

func _on_Entities_tab_changed(tab):
	if !Global.place_tile:
		if (!Global.filesystem_shown):
			if(current_item != null and can_place and Input.is_action_just_pressed("mb_left")):
				var new_item = current_item.instance()
				level.add_child(new_item)
				new_item.owner = level
				new_item.global_position = get_global_mouse_position()

func _on_AutoTile_tab_changed(tab):
	if !Global.place_tile:
		if (!Global.filesystem_shown):
			if(current_item != null and can_place and Input.is_action_just_pressed("mb_left")):
				var new_item = current_item.instance()
				level.add_child(new_item)
				new_item.owner = level
				new_item.global_position = get_global_mouse_position()

func _on_Deco_tab_changed(tab):
	if !Global.place_tile:
		if (!Global.filesystem_shown):
			if(current_item != null and can_place and Input.is_action_just_pressed("mb_left")):
				var new_item = current_item.instance()
				level.add_child(new_item)
				new_item.owner = level
				new_item.global_position = get_global_mouse_position()

func _on_Save_pressed():
	get_tree().paused = true
	editorspacecontrol.visible = false
	Global.filesystem_shown = true
	do_save = true
	popup.mode = 4
	popup.show()
	editorSpaceAni.play_backwards("transition")

func _on_Load_pressed():
	get_tree().paused = true
	editorspacecontrol.visible = false
	Global.filesystem_shown = true
	do_save = true
	popup.mode = 0
	popup.show()
	editorSpaceAni.play_backwards("transition")

func _on_HSlider_value_changed(value):
	var sp = get_owner().get_node("ItemSelectionScreen/BrushSize/HSlider/SliderPlayer")
	sp.play()
	brushlabel.text = str(value)
	brush_size = value
	set_new_cursor_shape()

func _on_CircleButton_toggled(button_pressed: bool) -> void:
	squarebutton.set_pressed_no_signal(false)
	circlebutton.set_pressed_no_signal(true)
	current_shape = BrushShape.CIRCLE
	set_new_cursor_shape()
	
func _on_SquareButton_toggled(button_pressed: bool) -> void:
	squarebutton.set_pressed_no_signal(true)
	circlebutton.set_pressed_no_signal(false)
	current_shape = BrushShape.SQUARE
	set_new_cursor_shape()

func _on_UiStyle_mouse_entered():
	can_place = false
	hide()
	pass # Replace with function body.

func _on_UiStyle_mouse_exited():
	can_place = true
	show()
	pass # Replace with function body.

func _on_ThemeButton_mouse_entered():
	can_place = false
	hide()

func _on_ThemeButton_mouse_exited():
	can_place = true
	show()

func _on_PlayButton_mouse_entered():
	sfx07_()
	can_place = false
	hide()

func _on_PlayButton_mouse_exited():
	can_place = true
	show()

func _on_BluePrintsButton_mouse_entered():
	can_place = false
	hide()

func _on_BluePrintsButton_mouse_exited():
	can_place = true
	show()

func _on_ObjectButton_mouse_entered():
	can_place = false
	hide()

func _on_ObjectButton_mouse_exited():
	can_place = true
	show()

func _on_EntityObjectPanel_mouse_entered():
	can_place = false
	hide()

func _on_EntityObjectPanel_mouse_exited():
	can_place = true
	show()

func _on_Panel_mouse_entered():
	can_place = false
	hide()
	
func _on_Panel_mouse_exited():
	can_place = true
	show()

func _on_Interactive_Objects_InteractiveMode():
	if !Global.place_tile:
		if (!Global.filesystem_shown):
			if(current_item != null and can_place and Input.is_action_just_pressed("mb_left")):
				var new_item = current_item.instance()
				level.add_child(new_item)
				new_item.owner = level
				new_item.global_position = get_global_mouse_position()

func _on_XButton_pressed():
	#emit_signal("EditMode")
	pass

func _on_ZoomIn_mouse_entered():
	sfx01_()
	can_place = false
	hide()
	
func _on_ZoomIn_mouse_exited():
	can_place = true
	show()
	
func _on_ZoomOut_mouse_entered():
	sfx01_()
	can_place = false
	hide()
	
func _on_ZoomOut_mouse_exited():
	can_place = true
	show()

func _on_StyleGroundButton_mouse_entered():
	can_place = false
	hide()

func _on_StyleGroundButton_mouse_exited():
	can_place = true
	show()

func _on_RoomManagmentButton_mouse_entered():
	can_place = false
	hide()

func _on_RoomManagmentButton_mouse_exited():
	can_place = true
	show()

func _on_TrashIcon_mouse_entered():
	can_place = false
	hide()

func _on_TrashIcon_mouse_exited():
	can_place = true
	show()

func _on_BackButton_mouse_entered():
	can_place = false
	hide()

func _on_BackButton_mouse_exited():
	can_place = true
	show()

func _on_TabContainer_mouse_entered():
	can_place = false
	hide()

func _on_TabContainer_mouse_exited():
	can_place = true
	show()

func _on_OtherPanel_mouse_entered():
	can_place = false
	hide()

func _on_OtherPanel_mouse_exited():
	can_place = true
	show()

func _on_BackButton_pressed():
	var ani = get_owner().get_node("EditorSpace/Control/AnimationPlayer")
	ani.play_backwards("transition")

func _on_ColorRect_mouse_entered():
	can_place = false
	hide()

func _on_ColorRect_mouse_exited():
	can_place = true
	show()

func _on_Header_mouse_entered():
	can_place = false
	hide()

func _on_Header_mouse_exited():
	can_place = true
	show()

func _on_Background_mouse_entered():
	can_place = false
	hide()

func _on_Background_mouse_exited():
	can_place = true
	show()
	
func _on_Button_mouse_entered():
	can_place = false
	hide()

func _on_Button_mouse_exited():
	can_place = true
	show()

func _on_ZoomIn_pressed():
	editor_cam.zoom += Vector2(0.2,0.2)
	sfx04_()

func _on_ZoomOut_pressed():
	editor_cam.zoom -= Vector2(0.2,0.2)
	sfx04_()

func _on_Pause_mouse_entered():
	sfx02_()

func _on_Space_mouse_entered():
	sfx02_()

func _on_Pause_pressed():
	sfx03_()

func _on_Space_pressed():
	sfx03_()

func _on_PlayButton_pressed():
	sfx06_()

func _on_Save_mouse_entered():
	can_place = false
	hide()
	sfx05_()

func _on_Load_mouse_entered():
	can_place = false
	hide()
	sfx05_()

func _on_Export_mouse_entered():
	can_place = false
	hide()
	sfx05_()

func _on_DiscButton_mouse_entered():
	can_place = false
	hide()
	sfx05_()

func _on_DiscButton_item_focused(index):
	sfx08_()

func _on_DiscButton_item_selected(index):
	sfx08_()
	
func sfx01_():
	sfx01.play()

func sfx02_():
	sfx02.play()

func sfx03_():
	sfx03.play()
	
func sfx04_():
	sfx04.play()
	
func sfx05_():
	sfx05.play()

func sfx06_():
	sfx06.play()

func sfx07_():
	sfx07.play()
	
func sfx08_():
	sfx08.play()

func sfx09_():
	sfx09.play()

func sfx10_():
	sfx10.play()
	
func sfx11_():
	sfx11.play()
	
func _on_Save_mouse_exited():
	can_place = true
	show()

func _on_Load_mouse_exited():
	can_place = true
	show()

func _on_Export_mouse_exited():
	can_place = true
	show()

func _on_DiscButton_mouse_exited():
	can_place = true
	show()

func _on_BGButton_mouse_entered():
	can_place = false
	hide()
	sfx11_()

func _on_BGButton_mouse_exited():
	can_place = true
	show()

func _on_back_mouse_entered():
	can_place = false
	hide()
	sfx10_()

func _on_back_mouse_exited():
	can_place = true
	show()

func _on_FileDialog_mouse_entered():
	can_place = false
	hide()

func _on_FileDialog_mouse_exited():
	can_place = true
	show()

func _on_melody_mouse_entered():
	can_place = false
	hide()
	sfx10_()

func _on_melody_mouse_exited():
	can_place = true
	show()

func _on_neorush_mouse_entered():
	can_place = false
	hide()
	sfx10_()

func _on_neorush_mouse_exited():
	can_place = true
	show()

func _on_lavahill_mouse_entered():
	can_place = false
	hide()
	sfx10_()

func _on_lavahill_mouse_exited():
	can_place = true
	show()

func _on_melodyotherside_mouse_entered():
	can_place = false
	hide()
	sfx10_()

func _on_melodyotherside_mouse_exited():
	can_place = true
	show()

func _on_neorushotherside_mouse_entered():
	can_place = false
	hide()
	sfx10_()

func _on_neorushotherside_mouse_exited():
	can_place = true
	show()

func _on_lavahillotherside_mouse_entered():
	can_place = false
	hide()
	sfx10_()

func _on_lavahillotherside_mouse_exited():
	can_place = true
	show()

func _on_Styleground_mouse_entered():
	can_place = false
	hide()
	sfx09_()

func _on_Styleground_mouse_exited():
	can_place = true
	show()
