extends Panel

var selected = false

onready var playerstate = get_node("/root/EditorState/PlayViewport/Player")
onready var object_cursor = get_node("/root/EditorState/Editor_Objects")
var focused_size = Vector2(24,24)
var unfocused_size = Vector2(16,16)

func _ready():
	pass

func _on_TabContainer_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()
	pass # Replace with function body.


func _on_TabContainer_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()
	pass # Replace with function body.


func _on_ItemTiles_focus_entered():
	$TabContainer/Cube/ScrollContainer/VBoxContainer/HBoxContainer/ItemTiles.rect_min_size = focused_size


func _on_ItemTiles_focus_exited():
	$TabContainer/Cube/ScrollContainer/VBoxContainer/HBoxContainer/ItemTiles.rect_min_size = unfocused_size
