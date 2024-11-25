extends Node2D

var sleep = false
var usable = false

func _input(event):
	if event.is_action_pressed("ui_inspect") and sleep and usable:
		$TopDownPlayer.set_physics_process(false)
		usable = false
		var newDialogue = Dialogic.start("Bed")
		add_child(newDialogue)
		newDialogue.connect("dialogic_signal", self, "entry")
		
func entry(argument):
	if argument == "sleep":
		BlackScreen.playEffect()
		$Timer.start()
	if argument == "exitos":
		$TopDownPlayer.set_physics_process(true)
	
func _on_Area_body_entered(body):
	usable = true
	sleep = true

func _on_Area_body_exited(body):
	sleep = false

func _on_Timer_timeout():
	$AnimationPlayer.play("sleep")
	$SecondTimer.start()
	
func _on_SecondTimer_timeout():
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/Stacy\'sHotelRoom.tscn")

func _on_EntranceArea_body_entered(body):
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/Stacy\'sHotelFloor2.tscn")
