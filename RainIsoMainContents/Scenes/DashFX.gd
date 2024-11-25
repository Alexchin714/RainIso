extends CheckBox

onready var player = get_node("Player")

func _ready():
	if DataManager.data["Settings"].has("dfx"):
		pressed = DataManager.data["Settings"]["dfx"]

func _on_DashFX_pressed():
	DataManager.data["Settings"]["dfx"] = pressed
	DataManager.save_data()
