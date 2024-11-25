extends KinematicBody2D

var toggle = false
export var dialogueKey = ""
signal finish

func _input(event):
	if event.is_action_pressed("ui_accept") and toggle == true:
		SignalBus.emit_signal("displayDialogue", dialogueKey)
		
func _on_Dialogue_finished():
	toggle = false
	transition()
	emit_signal("finish")

func transition():
	var ani = $AnimationPlayer
	ani.play("WalkAway")

func _on_Editor_dialogue():
	toggle = true
	SignalBus.emit_signal("displayDialogue", dialogueKey)
	
