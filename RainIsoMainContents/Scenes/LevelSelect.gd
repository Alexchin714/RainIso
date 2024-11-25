extends Control

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		var actlists = get_owner().get_node("TheActsList/AnimationPlayer")
		actlists.play_backwards("transition")
		
func _on_MelodyTownButton_pressed():
	#Global.is_in_level = true
	$Act1/AnimationPlayer1.play("pressed")
	yield(get_tree().create_timer(2), "timeout")
	SceneTransition.change_scene("res://RainIsoMainContents/MainLevels/MelodyTown.tscn")

func _on_NeoRushCityButton_pressed():
	#Global.is_in_level = true
	$Act1/AnimationPlayer2.play("pressed")
	yield(get_tree().create_timer(2), "timeout")
	SceneTransition.change_scene("res://RainIsoMainContents/MainLevels/NeoRushCity.tscn")

func _on_LavaHillButton_pressed():
	#Global.is_in_level = true
	$Act1/AnimationPlayer3.play("pressed")
	yield(get_tree().create_timer(2), "timeout")
	SceneTransition.change_scene("res://RainIsoMainContents/MainLevels/LavaHill.tscn")
