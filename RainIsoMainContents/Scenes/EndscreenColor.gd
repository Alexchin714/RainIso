extends CheckBox

func _ready():
	if DataManager.data["Settings"].has("endsc"):
		pressed = DataManager.data["Settings"]["endsc"]

func _on_EndscreenColor_pressed():
	DataManager.data["Settings"]["endsc"] = pressed
	DataManager.save_data()

