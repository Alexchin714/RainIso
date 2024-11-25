extends Node2D

var fridge = false
var tv = false
var flower = false
var table = false
var tarot = false
var tarotsec = false
var usable = false
var rema = false

func _input(event):
	if Input.is_action_just_pressed("ui_inspect") and usable and tarot:
		pause()
		var newDialogue = Dialogic.start("WillowTarots")
		add_child(newDialogue)
		newDialogue.connect("dialogic_signal", self, "choice")
		usable = false
	if Input.is_action_just_pressed("ui_inspect") and usable and tarotsec:
		pause()
		var newDialogue = Dialogic.start("WillowSecondTarots")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "dialog")
		newDialogue.connect("dialogic_signal", self, "choice")
		usable = false
	if Input.is_action_just_pressed("ui_inspect") and usable and fridge:
		pause()
		var newDialogue = Dialogic.start("WillowFridge")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "dialog")
		usable = false
	if Input.is_action_just_pressed("ui_inspect") and usable and tv:
		pause()
		var newDialogue = Dialogic.start("WillowTV")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "dialog")
		usable = false
	if Input.is_action_just_pressed("ui_inspect") and usable and flower:
		pause()
		var newDialogue = Dialogic.start("WillowFlower")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "dialog")
		usable = false
	if Input.is_action_just_pressed("ui_inspect") and usable and table:
		pause()
		var newDialogue = Dialogic.start("WillowTable")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "dialog")
		usable = false
	if Input.is_action_just_pressed("ui_inspect") and usable and rema:
		pause()
		var newDialogue = Dialogic.start("WillowRematch")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "dialog")
		newDialogue.connect("dialogic_signal", self, "choice")
		usable = false
		
func _on_Area_body_entered(body):
	SceneTransition.change_scene("res://RainIsoMainContents/MainLevels/MelodyTown.tscn")

func _on_TarotActivation_body_entered(body):
	usable = true
	tarot = true

func _on_TarotActivation_body_exited(body):
	tarot = false

func _on_FridgeArea_body_entered(body):
	usable = true
	fridge = true

func _on_FridgeArea_body_exited(body):
	fridge = false

func _on_TVArea_body_entered(body):
	usable = true
	tv = true

func _on_TVArea_body_exited(body):
	tv = false

func _on_FlowerArea_body_entered(body):
	usable = true
	flower = true

func _on_FlowerArea_body_exited(body):
	flower = false

func _on_TableArea_body_entered(body):
	usable = true
	table = true

func _on_TableArea_body_exited(body):
	table = false

func dialog(timeline_end):
	dialog_finish()
	
func dialog_finish():
	unpause()
	
func pause():
	$TopDownPlayer.set_physics_process(false)
	$TopDownPlayer.set_process_unhandled_input(false)
	
func unpause():
	$TopDownPlayer.set_physics_process(true)
	$TopDownPlayer.set_process_unhandled_input(true)

func choice(argument):
	if argument == "card":
		pause()
		$Timer.start()
		$BattlePlayer.play("start")
	if argument == "rematch":
		pause()
		$TarotBattleSystem/AnimationPlayer.playback_speed = 1
		$BattlePlayer.play("start")
		$TarotBattleSystem.battle()
		
func _on_TarotActivationSecond_body_entered(body):
	usable = true
	tarotsec = true

func _on_TarotActivationSecond_body_exited(body):
	tarotsec = false

func _on_Timer_timeout():
	$AnimationPlayer.play("up")
	yield(get_tree().create_timer(4), "timeout")
	$TarotBattleSystem.battle()
	$TarotActivation/CollisionShape2D.set_deferred("disabled", true)
	$TarotActivationSecond/CollisionShape2D.set_deferred("disabled", true)
	
func _on_TarotBattleSystem_ls():
	$TarotTryAgain/CollisionShape2D.set_deferred("disabled", false)
	unpause()
	if $TarotBattleSystem.won == true:
		var newDialogue = Dialogic.start("WillowWon")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "dialog")
		$TarotBattleSystem.won = false
	if $TarotBattleSystem.lost == true:
		var newDialogue = Dialogic.start("WillowLost")
		add_child(newDialogue)
		newDialogue.connect("timeline_end", self, "dialog")
		$TarotBattleSystem.lost = false

func _on_TarotTryAgain_body_entered(body):
	usable = true
	rema = true

func _on_TarotTryAgain_body_exited(body):
	rema = false
