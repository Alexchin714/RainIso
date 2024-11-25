extends Control

func _ready():
	yield(get_tree().create_timer(4), "timeout")
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/MenuTNAP.tscn")
