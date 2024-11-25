extends CanvasLayer

signal start
export var opened = false

func _ready():
	opened = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$StartUpTimer.start()
	
func _input(event):
	if event is InputEventKey and opened == true:
		if event.pressed:
			opened = false
			emit_signal("start")
			start()
			
func start():
	$TransitionalAnimationPlayer.play("transition")

func _on_StartUpTimer_timeout():
	$AnimationPlayer.play("Loop")
