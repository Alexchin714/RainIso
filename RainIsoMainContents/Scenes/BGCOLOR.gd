extends CheckBox

func _ready():
	if DataManager.data["Settings"].has("bgc"):
		pressed = DataManager.data["Settings"]["bgc"]

func _on_BGColor_pressed():
	DataManager.data["Settings"]["bgc"] = pressed
	DataManager.save_data()
