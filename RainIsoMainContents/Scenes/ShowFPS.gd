extends CheckBox

func _ready():
	if DataManager.data["Settings"].has("fps"):
		pressed = DataManager.data["Settings"]["fps"]

func _on_ShowFPS_pressed():
	DataManager.data["Settings"]["fps"] = pressed
	DataManager.save_data()
