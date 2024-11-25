extends Node

func skip():
	if Input.is_action_just_pressed("skip_cutscene") and Cutscene.cutscene == true:
		BlackScreen.playEffect()
		
