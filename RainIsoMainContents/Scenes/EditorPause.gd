extends CanvasLayer

signal EndLevel
onready var node = get_node("res://EditorState/CanvasLayer/EditorPauseButton")
onready var object_cursor = get_node("/root/EditorState/Editor_Objects")
export(Script) var game_save_class

func _ready():
	set_visible(false)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		$Control/Bg.visible = !$Control/Bg.visible
	
func _on_Continue_pressed():
	get_tree().paused = false
	set_visible(false)

func _on_Exit_pressed():
	get_tree().paused = false
	set_visible(false)
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/TitleScreen.tscn")
	
func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible

func _on_Control_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()
	pass # Replace with function body.


func _on_Control_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()
	pass # Replace with function body.
