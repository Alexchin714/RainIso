extends Button

signal ChangeKey_Up
signal ChangeKey_Down
signal ChangeKey_Left
signal ChangeKey_Right
signal ChangeKey_Jump
signal ChangeKey_Climb

func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("jump"):
		print("Jump")
	if event.is_action_pressed("climb"):
		print("Crouch")
	if event.is_action_pressed("w"):
		print("Kiss")
