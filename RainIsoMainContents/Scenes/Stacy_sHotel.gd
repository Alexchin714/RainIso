extends Node2D

var canoli = false
var dialog = false
var usable = false
var carmine = false
var velocityy = false
	
func _input(event):
	if event.is_action_pressed("ui_inspect") and dialog and usable:
		$TopDownPlayer.set_physics_process(false)
		usable = false
		var newDialogue = Dialogic.start("Stacy")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "finish_dialog")
		newDialogue.connect("dialogic_signal", self, "entry")
	if event.is_action_pressed("ui_inspect") and canoli and usable:
		$TopDownPlayer.set_physics_process(false)
		usable = false
		if carmine == true:
			var newDialogue = Dialogic.start("FurizAlexSecondary")
			add_child(newDialogue)
			newDialogue.connect("timeline_end", self, "finish_dialog")
		if carmine == false:
			carmine = true
			var newDialogue = Dialogic.start("FurizAlex")
			add_child(newDialogue)
			newDialogue.connect("timeline_end", self, "finish_dialog")
			
func _process(delta):
	if velocityy == true:
		$TopDownPlayer.velocity.x += 500
		
func entry(argument):
	if argument == "open":
		$Blocker/CollisionShape2D.set_deferred("disabled", true)
	
func finish_dialog(timeline_end):
	finish()
	
func finish():
	$TopDownPlayer.set_physics_process(true)
	
func _on_ExitArea_body_entered(body: KinematicBody2D):
	SceneTransition.change_scene("res://RainIsoMainContents/MainLevels/MelodyTown.tscn")

func _on_SecondFloor_body_entered(body: KinematicBody2D):
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/Stacy\'sHotelFloor2.tscn")

func _on_Stacy_body_entered(body):
	usable = true
	dialog = true

func _on_Stacy_body_exited(body):
	dialog = false

func _on_CanoliArea_body_entered(body):
	usable = true
	canoli = true

func _on_CanoliArea_body_exited(body):
	canoli = false

func _on_NoENTRY_body_entered(body):
	velocityy = true

func _on_NoENTRY_body_exited(body):
	velocityy = false
