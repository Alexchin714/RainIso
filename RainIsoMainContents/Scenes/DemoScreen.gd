extends Node2D

var a = false

func _ready():
	$Timer.start()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and a == true:
		SceneTransition.change_scene("res://RainIsoMainContents/Scenes/LoadingScreen.tscn")

func _on_Timer_timeout():
	a = true

func start():
	$System.play()
	$Music.play()
