extends Area2D

signal easterfish
export var dialogueKey = ""
var returnActive = 0
var areaActive = false

func _process(delta):
	if returnActive > 1:
		return
		
func _input(event):
	if areaActive and event.is_action_pressed("dash"):
		SignalBus.emit_signal("displayDialogue", dialogueKey)
	
func _on_DialogueArea_body_entered(body):
	areaActive = true
	if areaActive == true:
		returnActive += 1
	if dialogueKey == "Boot":
		emit_signal("easterfish")
		
func _on_DialogueArea_body_exited(body):
	areaActive = false
	if areaActive == false:
		returnActive = 0
