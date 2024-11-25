extends CanvasLayer

onready var plant_tiny_tunes = get_node("Music/PlantTinyTunes")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _on_Timer_timeout():
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/DemoScreen.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
