extends Control

var confirmed = false

func _ready():
	connect("mouse_entered", self,"_on_Button_mouse_entered")
	connect("pressed",self,"_on_Button_Pressed")
		
func _on_Button_mouse_entered():
	grab_focus()
	
func _on_No_focus_entered():
	$Focuser.play("yes1")

func _on_No_focus_exited():
	$Focuser.play("no1")

func _on_Yes_focus_entered():
	$Focuser.play("yes2")

func _on_Yes_focus_exited():
	$Focuser.play("no2")

func _on_No_pressed():
	confirmed = true
	
	$AudioStreamPlayer.play()
	$AnimationPlayer.play_backwards("quit")

func _on_Yes_pressed():
	confirmed = false
	$AudioStreamPlayer.play()
	if confirmed == false:
		get_tree().quit()
