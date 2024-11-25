extends CheckBox

func _ready():
	if DataManager.data["Settings"].has("display_checked"):
		pressed = DataManager.data["Settings"]["display_checked"]


func _on_DisplayCheck_pressed():
	DataManager.data["Settings"]["display_checked"] = pressed
	DataManager.save_data()
