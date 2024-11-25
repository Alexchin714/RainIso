extends CheckBox

func _ready():
	if DataManager.data["Settings"].has("box_checked"):
		pressed = DataManager.data["Settings"]["box_checked"]

func _on_Fullscreen_toggled(button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen
	DataManager.data["Settings"]["box_checked"] = pressed
	DataManager.save_data()
