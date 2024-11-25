extends CheckBox

func _ready():
	if DataManager.data["Settings"].has("smooth_checked"):
		pressed = DataManager.data["Settings"]["smooth_checked"]

func _on_Smoothfix_pressed():
	DataManager.data["Settings"]["smooth_checked"] = pressed
	DataManager.save_data()
