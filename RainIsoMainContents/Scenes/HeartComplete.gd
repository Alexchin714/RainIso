extends Control

func _on_BonusHeart_body_entered(body):
	$BonusLevelComplete/AnimationPlayer.play("bonuslevelcomplete")
	$Timer.start()
	
func _on_Timer_timeout():
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/LevelSelectionScreen.tscn")
