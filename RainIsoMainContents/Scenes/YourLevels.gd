extends Control

const SAVE_DIR = "user://saves/"

var save_path = SAVE_DIR + "save.dat"

func _ready():
	pass
		
func _on_CreateNew_pressed():
	var scene = load("res://CreateNewLevel.tscn")
	var NewLevel = scene.instance()
	get_tree().set_current_scene(NewLevel)
	add_child(NewLevel)

func _on_Button_pressed():
	get_tree().change_scene("res://Miscellaneous.tscn")
