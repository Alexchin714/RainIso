extends Node2D

func _ready():
	#var newDialogue = Dialogic.start("JakieShop")
	#add_child(newDialogue)
	#newDialogue.connect("timeline_end", self, "reset")
	#newDialogue.connect("dialogic_signal", self, "dialog_signal")
	pass
	
func dialog_signal(argument):
	SceneTransition.change_scene("res://RainIsoMainContents/MainLevels/MelodyTown.tscn")
	if argument == "sellPhase":
		pass
	if argument == "buyPhase":
		pass
	if argument == "exitPhase":
		exit()

func exit():
	SceneTransition.change_scene("res://RainIsoMainContents/MainLevels/MelodyTown.tscn")
	
#func reset(timeline_end):
	#var newDialogue = Dialogic.start("JakieShop")
	#add_child(newDialogue)
	#newDialogue.connect("dialog_signal", self, "after_dialog")

func _on_Item01_mouse_entered():
	$NamePlate.visible = true
	$NamePlate/Panel/Label.text = "15"
	$NamePlate/Panel/Title.text = "Binoculars"
	$NamePlate/Panel/Description.text = "Binoculars allow you to zoom in and free look in a certain radius, when moving while using the binoculars you’re vision will blur."

func _on_Item01_mouse_exited():
	$NamePlate.visible = false

func _on_Item02_mouse_entered():
	$NamePlate.visible = true
	$NamePlate/Panel/Label.text = "5"
	$NamePlate/Panel/Title.text = "Shroom Pamera"
	$NamePlate/Panel/Description.text = ""

func _on_Item02_mouse_exited():
	$NamePlate.visible = false

func _on_Item03_mouse_entered():
	$NamePlate.visible = true
	$NamePlate/Panel/Label.text = "20"
	$NamePlate/Panel/Title.text = "Running Shoes"
	$NamePlate/Panel/Description.text = ""

func _on_Item03_mouse_exited():
	$NamePlate.visible = false

func _on_Item04_mouse_entered():
	$NamePlate.visible = true
	$NamePlate/Panel/Label.text = "10"
	$NamePlate/Panel/Title.text = "Fishing Rod"
	$NamePlate/Panel/Description.text = ""

func _on_Item04_mouse_exited():
	$NamePlate.visible = false

func _on_Item05_mouse_entered():
	$NamePlate.visible = true
	$NamePlate/Panel/Label.text = "10"
	$NamePlate/Panel/Title.text = "Stick"
	$NamePlate/Panel/Description.text = ""

func _on_Item05_mouse_exited():
	$NamePlate.visible = false

func _on_Item06_mouse_entered():
	$NamePlate.visible = true
	$NamePlate/Panel/Label.text = "20"
	$NamePlate/Panel/Title.text = "Heavy Boots"
	$NamePlate/Panel/Description.text = ""

func _on_Item06_mouse_exited():
	$NamePlate.visible = false
