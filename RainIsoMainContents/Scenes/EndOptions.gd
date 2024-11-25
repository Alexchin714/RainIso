extends CanvasLayer

onready var player = get_owner().get_node("TopDownPlayer")

func _on_End_EndOption():
	player.set_physics_process(false)
	$Backdrop/Yes.focus_mode = Control.FOCUS_ALL
	$Backdrop/No.focus_mode = Control.FOCUS_ALL
	$Backdrop/Yes.grab_focus()
	$Backdrop.visible = true

func _on_Yes_pressed():
	$Backdrop/AudioStreamPlayer.play()
	SceneTransition.change_scene("res://RainIsoMainContents/MainLevels/ThePrologue.tscn")

func _on_No_pressed():
	$Backdrop/AudioStreamPlayer.play()
	player.set_physics_process(true)
	$Backdrop/Yes.focus_mode = Control.FOCUS_NONE
	$Backdrop/No.focus_mode = Control.FOCUS_NONE
	$Backdrop.visible = false
