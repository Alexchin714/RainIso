extends CanvasLayer

func _on_StarChapterComplete_body_entered(body):
	$Control/AnimationPlayer.play("ChapterCompleteScreen")
	$Control/ChapterTimer.start()
	
func StarLit_Complete():
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/TitleScreen.tscn")

func _on_ChapterTimer_timeout():
	StarLit_Complete()

func _on_Button_pressed():
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/TitleScreen.tscn")
