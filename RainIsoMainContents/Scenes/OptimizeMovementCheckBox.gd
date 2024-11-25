extends CheckBox

func _ready():
	if DataManager.data["Settings"].has("optimize_checked"):
		pressed = DataManager.data["Settings"]["optimize_checked"]

func _on_VSync_pressed():
	DataManager.data["Settings"]["optimize_checked"] = pressed
	DataManager.save_data()
