extends Control

var safetysignal = false

func _ready():
	if DataManager.data["Settings"].has("kb"):
		visible = DataManager.data["Settings"]["kb"]

func _on_Button_pressed():
	get_tree().change_scene("res://DisplaySettings.tscn")


func _on_Button2_pressed():
	get_tree().change_scene("res://ServerSettings.tscn")

func _on_ShowFPS_toggled(button_pressed):
	$MarginContainer/FPSCounter.visible = true
	DataManager.data["Settings"]["kb"] = visible
	DataManager.save_data()
