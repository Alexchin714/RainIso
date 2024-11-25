extends Node2D

var player_position = Vector2()
onready var editmode = true
onready var editsaved = false
onready var worldmap = ""
var current_level = ""
var can_edit = true

func editmode_toggle():
	if editmode == false:
		editmode = true
			# Store if the previous level was a worldmap
		var prevworldmap = get_node("Level").worldmap
		player_position = get_node("Player").position
		clear_ui()

		if editsaved == false:
			if worldmap == "":
				load_level(current_level)
			else: load_level(worldmap)
		else: load_edited_level()
		load_player()

			# Only move the player if the current level is the same type as the previous
		if get_node("Level").worldmap == prevworldmap:
			get_node("Player").position = player_position
		else:
			get_node("Camera2D").position = get_node("Player").position

	elif get_node("Editor").dragging_object == false:
		editmode = false
		save_edited_level()
		if editsaved == false:
			load_level(current_level)
		else: load_edited_level()
		
func _clear_node(node_name):
	var node = get_node(node_name)
	for i in node.get_children():
		i.queue_free()
	remove_child(node)
	node.call_deferred("free")

func clear_ui():
	_clear_node("LevelUI")
	
func _load_node(scene_path, node_name):
	var scene = load(scene_path).instance()
	scene.set_name(node_name)
	add_child(scene)
	
func load_player():
	if get_node("Level").worldmap:
		_load_node("res://RainIsoMainContents/Scenes/Editor.tscn", "Player")
	else:
		_load_node("res://RainIsoMainContents/Scenes/Editor.tscn", "Player")
		
func load_level(level):
	current_level = level
	var directory = Directory.new()
	if directory.file_exists(level):
		var levelinstance = load(level).instance()
		if levelinstance.worldmap:
			worldmap = level
		levelinstance.set_name("Level")
		add_child(levelinstance)
		level_to_grid()

func load_edited_level():
	load_level("user://Scenes/Levels/EditedLevel/EditedLevel.tscn")
	
func level_to_grid():
	for child in get_tree().current_scene.get_node("Level").get_children():
		if not child.is_in_group("tilemap"):
			child.position.x = floor(child.position.x / 32) * 32
			child.position.y = floor(child.position.y / 32) * 32
			child.position.x += 16
			child.position.y += 16

func save_edited_level():
	var packed_scene = PackedScene.new()
	var directory = Directory.new()
	packed_scene.pack(get_tree().get_current_scene().get_node("Level"))

	if not directory.dir_exists("user://Scenes/Levels/EditedLevel"):
		directory.make_dir_recursive("user://Scenes/Levels/EditedLevel")

	ResourceSaver.save("user://Scenes/Levels/EditedLevel/EditedLevel.tscn", packed_scene)
	editsaved = true
