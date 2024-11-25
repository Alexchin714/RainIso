extends CanvasLayer

func completeSave():
	if !Cutscene.cutscene or Global.battlestart:
		$AnimationPlayer.play("save")
	else:
		$AnimationPlayer.play("savecannot")
