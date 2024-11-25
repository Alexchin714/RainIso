extends CanvasLayer

var toggle = false
export var num = 1
onready var pages = [$Container/DailyNews01, $Container/DailyNews02, $Container/DailyNews03, $Container/DailyNews04]

func _process(delta):
	if num < 1:
		num += 1
	elif num > 4:
		num -= 1
	match num:
		1:
			pages[0].show()
			pages[1].hide()
			pages[2].hide()
			pages[3].hide()
		2:
			pages[1].show()
			pages[0].hide()
			pages[2].hide()
			pages[3].hide()
		3:
			pages[2].show()
			pages[0].hide()
			pages[1].hide()
			pages[3].hide()
		4:
			pages[3].show()
			pages[0].hide()
			pages[1].hide()
			pages[2].hide()

func _input(event):
	if Input.is_action_just_pressed("a") and toggle == true:
		num -= 1
	if Input.is_action_just_pressed("d") and toggle == true:
		num += 1
		
func _on_Left_pressed():
	num -= 1

func _on_Right_pressed():
	num += 1

func _on_Area2D_body_entered(body):
	toggle = true

func _on_Area2D_body_exited(body):
	toggle = false
