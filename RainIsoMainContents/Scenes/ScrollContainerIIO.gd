extends ScrollContainer

onready var object_cursor = get_node("/root/EditorState/Editor_Objects")
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("mouse_entered" ,self, "mouse_enter")
	connect("mouse_exited" ,self, "mouse_leave")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#

func _on_ScrollContainer_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()
	pass

func _on_ScrollContainer_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()
	pass
