extends CanvasLayer

onready var mod = get_node("../Level/EnviromentalLighting/CanvasModulate")

func _on_BluePrintsButton_toggled(button_pressed):
	#get_tree().set_debug_collisions_hint(1) 
	#get_tree().is_debugging_collisions_hint()
	$AnimationPlayer.play("TransitionBlueprints")
	yield(get_tree().create_timer(1), "timeout")
	$ColorRect/Control.visible = button_pressed
	$Timer.start()
	
func _on_Timer_timeout():
	$AnimationPlayer.play_backwards("TransitionBlueprints")
