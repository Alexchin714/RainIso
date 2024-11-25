extends CheckBox

func _ready():
	if DataManager.data["Settings"].has("cursor"):
		pressed = DataManager.data["Settings"]["cursor"]

func _on_ShowCursor_pressed():
	DataManager.data["Settings"]["cursor"] = pressed
	DataManager.save_data()
