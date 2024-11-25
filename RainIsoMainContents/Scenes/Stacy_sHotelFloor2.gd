extends Node2D

var one = false
var two = false
var three = false
var four = false
var five = false
var six = false
var seven = false
var eight = false
var nine = false
var ten = false
var eleven = false
var twelve = false #At this point im at no fucking return in terms of coming up with variables
var usable = false

func _input(event):
	if event.is_action_pressed("ui_inspect") and one and usable:
		$TopDownPlayer.set_physics_process(false)
		usable = false
		var newDialogue = Dialogic.start("HotelOccupied")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "finish_dialog")
	if event.is_action_pressed("ui_inspect") and two and usable:
		$TopDownPlayer.set_physics_process(false)
		usable = false
		var newDialogue = Dialogic.start("HotelOccupied")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "finish_dialog")
	if event.is_action_pressed("ui_inspect") and three and usable:
		$TopDownPlayer.set_physics_process(false)
		usable = false
		var newDialogue = Dialogic.start("HotelWeed")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "finish_dialog")
	if event.is_action_pressed("ui_inspect") and four and usable:
		$TopDownPlayer.set_physics_process(false)
		usable = false
		var newDialogue = Dialogic.start("HotelOccupied")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "finish_dialog")
	if event.is_action_pressed("ui_inspect") and five and usable:
		$TopDownPlayer.set_physics_process(false)
		usable = false
		var newDialogue = Dialogic.start("HotelOccupied")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "finish_dialog")
	if event.is_action_pressed("ui_inspect") and six and usable:
		$TopDownPlayer.set_physics_process(false)
		usable = false
		var newDialogue = Dialogic.start("HotelOccupied")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "finish_dialog")
	if event.is_action_pressed("ui_inspect") and seven and usable:
		$TopDownPlayer.set_physics_process(false)
		usable = false
		var newDialogue = Dialogic.start("HotelArgument")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "finish_dialog")
	if event.is_action_pressed("ui_inspect") and eight and usable:
		$TopDownPlayer.set_physics_process(false)
		usable = false
		var newDialogue = Dialogic.start("HotelOccupied")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "finish_dialog")
	if event.is_action_pressed("ui_inspect") and nine and usable:
		$TopDownPlayer.set_physics_process(false)
		usable = false
		var newDialogue = Dialogic.start("HotelOccupied")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "finish_dialog")
	if event.is_action_pressed("ui_inspect") and ten and usable:
		$TopDownPlayer.set_physics_process(false)
		usable = false
		var newDialogue = Dialogic.start("HotelWrestling")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "finish_dialog")
	if event.is_action_pressed("ui_inspect") and eleven and usable:
		SceneTransition.change_scene("res://RainIsoMainContents/Scenes/Stacy\'sHotelRoom.tscn")
	if event.is_action_pressed("ui_inspect") and twelve and usable:
		$TopDownPlayer.set_physics_process(false)
		usable = false
		var newDialogue = Dialogic.start("HotelOccupied")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "finish_dialog")
		
func finish_dialog(timeline_end):
	finish()
	
func finish():
	$TopDownPlayer.set_physics_process(true)
	
func _on_FirstFloor_body_entered(body):
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/Stacy\'sHotel.tscn")

func _on_Door01_body_entered(body):
	one = true
	usable = true

func _on_Door01_body_exited(body):
	one = false

func _on_Door02_body_entered(body):
	two = true
	usable = true

func _on_Door02_body_exited(body):
	two = false

func _on_Door03_body_entered(body):
	three = true
	usable = true

func _on_Door03_body_exited(body):
	three = false

func _on_Door04_body_entered(body):
	four = true
	usable = true

func _on_Door04_body_exited(body):
	four = false

func _on_Door05_body_entered(body):
	five = true
	usable = true

func _on_Door05_body_exited(body):
	five = false

func _on_Door06_body_entered(body):
	six = true
	usable = true

func _on_Door06_body_exited(body):
	six = false

func _on_Door07_body_entered(body):
	seven = true
	usable = true

func _on_Door07_body_exited(body):
	seven = false

func _on_Door08_body_entered(body):
	eight = true
	usable = true

func _on_Door08_body_exited(body):
	eight = false

func _on_Door09_body_entered(body):
	nine = true
	usable = true

func _on_Door09_body_exited(body):
	nine = false

func _on_Door10_body_entered(body):
	ten = true
	usable = true

func _on_Door10_body_exited(body):
	ten = false

func _on_Door11_body_entered(body):
	eleven = true
	usable = true

func _on_Door11_body_exited(body):
	eleven = false

func _on_Door12_body_entered(body):
	twelve = true
	usable = true

func _on_Door12_body_exited(body):
	twelve = false
