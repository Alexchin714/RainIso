extends TextureRect

export(PackedScene) var this_scene
onready var object_cursor = get_node("/root/EditorState/Editor_Objects")
onready var move = get_node("/root/EditorState/Editor_Objects")
onready var global_position = get_global_mouse_position()

onready var cursor_sprite = object_cursor.get_node("Sprite")

export(bool) var tile = false
export var tile_id = 0

func _ready():
	connect("gui_input", self, "_item_clicked")
	#if DataManager.data["Objects"].has(name):
		#DataManager.data["Objects"][name]
	
func _process(delta):
	global_position = get_global_mouse_position()
	
func _item_clicked(event):
	if(event is InputEvent):
		if(!tile):
			if(event.is_action_pressed("mb_left")):
				object_cursor.current_item = this_scene
				cursor_sprite.texture = texture
				Global.place_tile = false
		else:
			if(event.is_action_pressed("mb_left")):
				Global.place_tile = true
				Global.current_tile = tile_id
				#DataManager.data["Objects"][name] = global_position
				#DataManager.save_data()
			cursor_sprite.texture = null
	pass

func update_look_direction(direction):
		$Pivot/ItemDefaultTest.rotation = direction.angle()
