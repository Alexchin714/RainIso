extends CheckBox
func _ready():
	if DataManager.data["Settings"].has("pausebutton"):
		pressed = DataManager.data["Settings"]["pausebutton"]

func _on_PauseButton_pressed():
	DataManager.data["Settings"]["pausebutton"] = pressed
	DataManager.save_data()
