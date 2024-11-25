extends CanvasLayer

onready var createOpen = false

func _input(event):
	if Input.is_action_just_pressed("ui_cancel") and createOpen:
		$AnimationPlayer.play_backwards("createactivation")
		createOpen = false
		
func _on_CreateButton_pressed():
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/Editor.tscn")

func _on_PlayButton_pressed():
	#SceneTransition.change_scene("res://RainIsoMainContents/Scenes/OnlineLevelList.tscn")
	pass

func _on_BackButton_pressed():
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/TitleScreen.tscn")

func _on_MinigameButton_pressed():
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/MiniGames.tscn")

func _on_Button_pressed():
	
	$AnimationPlayer.play_backwards("createactivation")

func _on_Create_pressed():
	createOpen = true
