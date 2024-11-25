extends Area2D

func _input(event):
	if Input.is_action_just_pressed("accept") and len(get_overlapping_bodies()) > 0:
		useDialogue()
		
func useDialogue():
	var dialogue = get_owner().get_node("Dialogue")
	
	if dialogue:
		dialogue.start()
		
