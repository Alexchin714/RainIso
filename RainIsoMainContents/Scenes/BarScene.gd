extends Node2D

var usable = false
var bathroom = false
var noble = false
var iamtootiredforthisshit = false
var bruh = false
var e = false
var theletterE = false
var maggots = false
var abucket = false
var teleportingbread = false
var furizalex = false
var cantthinkofanynameforvariable = false

func _ready():
	if Global.tobybar == true:
		$AnimationPlayer.play("TobyBar")
		yield($AnimationPlayer, "animation_finished")
		var newDialogue = Dialogic.start("TobyMainConvo")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "after_dialog")
		
func _input(event):
	if event.is_action_pressed("ui_inspect") and bathroom and usable:
		usable = false
		$TopDownPlayer.set_physics_process(false)
		var newDialogue = Dialogic.start("BarBathroom")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "after_dialog")
	if event.is_action_pressed("ui_inspect") and noble and usable:
		usable = false
		$TopDownPlayer.set_physics_process(false)
		var newDialogue = Dialogic.start("NobleDrinker")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "after_dialog")
	if event.is_action_pressed("ui_inspect") and iamtootiredforthisshit and usable:
		usable = false
		$TopDownPlayer.set_physics_process(false)
		var newDialogue = Dialogic.start("BarVermillion")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "after_dialog")
	if event.is_action_pressed("ui_inspect") and e and usable:
		usable = false
		$TopDownPlayer.set_physics_process(false)
		var newDialogue = Dialogic.start("TheTraveller")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "after_dialog")
	if event.is_action_pressed("ui_inspect") and theletterE and usable:
		usable = false
		$TopDownPlayer.set_physics_process(false)
		var newDialogue = Dialogic.start("Cofhgen")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "after_dialog")
	if event.is_action_pressed("ui_inspect") and maggots and usable:
		usable = false
		$TopDownPlayer.set_physics_process(false)
		var newDialogue = Dialogic.start("Brock")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "after_dialog")
	if event.is_action_pressed("ui_inspect") and abucket and usable:
		usable = false
		$TopDownPlayer.set_physics_process(false)
		var newDialogue = Dialogic.start("Elmon")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "after_dialog")
	if event.is_action_pressed("ui_inspect") and teleportingbread and usable:
		usable = false
		$TopDownPlayer.set_physics_process(false)
		var newDialogue = Dialogic.start("CoryT")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "after_dialog")
	if event.is_action_pressed("ui_inspect") and furizalex and usable:
		usable = false
		$TopDownPlayer.set_physics_process(false)
		var newDialogue = Dialogic.start("Gene")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "after_dialog")
		
func finish():
	$TopDownPlayer.set_physics_process(true)
	
func after_dialog(timeline_end):
	finish()
	
func _on_DaExit_body_entered(body):
	SceneTransition.change_scene("res://RainIsoMainContents/MainLevels/MelodyTown.tscn")

func _on_DaBathroom_body_entered(body: KinematicBody2D):
	usable = true
	bathroom = true

func _on_DaBathroom_body_exited(body: KinematicBody2D):
	bathroom = false

func _on_Guy01_body_entered(body: KinematicBody2D):
	usable = true
	noble = true

func _on_Guy01_body_exited(body: KinematicBody2D):
	noble = false

func _on_Vermillion_body_entered(body: KinematicBody2D):
	usable = true
	iamtootiredforthisshit = true

func _on_Vermillion_body_exited(body: KinematicBody2D):
	iamtootiredforthisshit = false

func _on_Guy02_body_entered(body: KinematicBody2D):
	usable = true
	bruh = true

func _on_Guy02_body_exited(body: KinematicBody2D):
	bruh = false

func _on_Guy03_body_entered(body: KinematicBody2D):
	usable = true
	e = true

func _on_Guy03_body_exited(body: KinematicBody2D):
	e = false

func _on_Guy04_body_entered(body: KinematicBody2D):
	usable = true
	theletterE = true

func _on_Guy04_body_exited(body: KinematicBody2D):
	theletterE = false

func _on_Guy05_body_entered(body: KinematicBody2D):
	usable = true
	maggots = true

func _on_Guy05_body_exited(body: KinematicBody2D):
	maggots = false

func _on_Guy06_body_entered(body: KinematicBody2D):
	usable = true
	abucket = true

func _on_Guy06_body_exited(body: KinematicBody2D):
	abucket = false

func _on_Guy07_body_entered(body: KinematicBody2D):
	usable = true
	teleportingbread = true

func _on_Guy07_body_exited(body: KinematicBody2D):
	teleportingbread = false

func _on_Guy08_body_entered(body: KinematicBody2D):
	usable = true
	furizalex = true

func _on_Guy08_body_exited(body: KinematicBody2D):
	furizalex = false

func _on_Guy09_body_entered(body: KinematicBody2D):
	usable = true
	cantthinkofanynameforvariable = true

func _on_Guy09_body_exited(body):
	cantthinkofanynameforvariable = false
