extends Node2D

var r = RandomNumberGenerator.new()
var i = false
var usable = false

func _ready():
	usable = true
	r.randomize() 
	$Fishing.play()

func _input(event):
	if Input.is_action_just_pressed("ui_left") and usable:
		usable = false
		var newDialogue = Dialogic.start("Fishing")
		add_child(newDialogue)
		newDialogue.connect("dialogic_signal", self, "fishing")
		$TurnTimer.start()
		
func _process(delta):
	$Label.text = str($FishingTimer.wait_time)

func fishing(argument):
	if argument == "fish":
		$FishingUI/Fishing.visible = true
		$FishingUI/Fishing/AnimationPlayer.play("bar")
		yield($FishingUI/Fishing/AnimationPlayer, "animation_finished")
		$FishingUI/Fishing.visible = false

func _on_TurnTimer_timeout():
	usable = true

func _on_FishingUI_done():
	$FishingHook/AnimationPlayer.play("hook")
	fishProcess()
	
func fishProcess():
	$FishingTimer.wait_time = (r.randf_range(1, 15))
	$FishingTimer.start()

func _on_FishingTimer_timeout():
	caught()
	$FishingTimer.wait_time = 1

func caught():
	$FishingHook/AnimationPlayer.play("hook")
