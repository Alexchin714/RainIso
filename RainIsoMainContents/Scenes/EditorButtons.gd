extends Button

onready var object_cursor = get_node("/root/Editor/Editor_Objects")
export var reference_path = ""
export(bool) var start_focused = false
onready var undo_redo = get_undo_redo() # Method of EditorPlugin.

func _ready():
	if(start_focused):
		grab_focus()

	connect("mouse_entered",self,"_on_Button_mouse_entered")
	connect("pressed",self,"_on_Button_Pressed")

func _on_Button_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()
	grab_focus()

func _on_Button_Pressed():
	if(reference_path != ""):
		get_tree().change_scene(reference_path)

func undo_redo():
	pass # Put your code here.
	
func get_undo_redo():
	pass # Put your code here.

func do_something():
	pass # Put your code here.

func undo_something():
	pass # Put here the code that reverts what's done by "do_something()".

func _on_MyButton_pressed():
	var node = get_node("Button")
	undo_redo.create_action("Move the node")
	undo_redo.add_do_method(self, "do_something")
	undo_redo.add_undo_method(self, "undo_something")
	undo_redo.add_do_property(node, "position", Vector2(100,100))
	undo_redo.add_undo_property(node, "position", node.position)
	undo_redo.commit_action()

