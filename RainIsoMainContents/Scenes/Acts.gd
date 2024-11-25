extends Control

onready var act1set = get_owner().get_node("Slots/Act1")
onready var act2set = get_owner().get_node("Slots/Act2")
onready var act3set = get_owner().get_node("Slots/Act3")
onready var act4set = get_owner().get_node("Slots/Act4")
onready var toppanel1 = get_owner().get_node("Slots/TopPanel1")
onready var toppanel2 = get_owner().get_node("Slots/TopPanel2")
onready var toppanel3 = get_owner().get_node("Slots/TopPanel3")
onready var toppanel4 = get_owner().get_node("Slots/TopPanel4")
onready var act1 = $Act1
onready var act2 = $Act2
onready var act3 = $Act3
onready var act4 = $Act4
var acts = 1

func _process(delta):
	if acts < 1:
		acts += 1
	elif acts > 4:
		acts -= 1
	if acts == 1:
		act1set.visible = true
		act2set.visible = false
		act3set.visible = false
		act4set.visible = false
		act1.visible = true
		act2.visible = false
		act3.visible = false
		act4.visible = false
	elif acts == 2:
		act1set.visible = false
		act2set.visible = true
		act3set.visible = false
		act4set.visible = false
		act1.visible = false
		act2.visible = true
		act3.visible = false
		act4.visible = false
	elif acts == 3:
		act1set.visible = false
		act2set.visible = false
		act3set.visible = true
		act4set.visible = false
		act1.visible = false
		act2.visible = false
		act3.visible = true
		act4.visible = false
	elif acts == 4:
		act1set.visible = false
		act2set.visible = false
		act3set.visible = false
		act4set.visible = true
		act1.visible = false
		act2.visible = false
		act3.visible = false
		act4.visible = true
		
func _on_LeftArrow_pressed():
	acts -= 1

func _on_RightArrow_pressed():
	acts += 1
