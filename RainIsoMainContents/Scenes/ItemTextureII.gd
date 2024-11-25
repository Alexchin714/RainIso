extends TextureRect

func _on_Entity_area_entered(area) -> void:
	if area.is_in_group("player"):
		pass

export(PackedScene) var this_scene
onready var object_cursor = get_node("/root/Editor/Editor_Objects")

onready var cursor_sprite = object_cursor.get_node("Sprite")

export(bool) var tile = false
export var tile_id = 0

func _ready():
	connect("gui_input", self, "_item_clicked")
	pass #NotLive
	
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
			cursor_sprite.texture = null
	pass
