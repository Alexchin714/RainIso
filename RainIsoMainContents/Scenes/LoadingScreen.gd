extends Node2D

func _ready():
	GlobalSettings.connect("mono_loading", self, "mono")
	
func _on_Timer_timeout():
	#SceneTransition.change_scene("res://MelodyTown.tscn")
	pass
	
func mono(value):
	$BackgroundLayer.visible = value
