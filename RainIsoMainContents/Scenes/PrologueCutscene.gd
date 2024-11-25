extends Node2D

func _ready():
	Global.cutsceneOn = true
	Cutscene.changeToCutscene()

func _on_CutsceneArea2D_body_entered(body):
	Global.cutsceneOn = false
	Cutscene.rollBack()
	$CutsceneArea2D.queue_free()

func _on_Transition_body_entered(body):
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/LevelSelectionScreen.tscn")
