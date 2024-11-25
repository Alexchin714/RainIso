extends Control

func _ready():
	$Buttons/Act1.grab_focus()

func _on_Back_pressed():
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/TitleScreen.tscn")
