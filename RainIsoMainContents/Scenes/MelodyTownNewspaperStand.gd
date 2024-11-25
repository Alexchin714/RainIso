extends Node2D

onready var player = get_owner().get_node("Player")
var toggle = false
var bepis = false

func _input(event):
	if Input.is_action_just_pressed("ui_accept") and toggle == true:
		bepis = !bepis
	if bepis == true:
		$DailyNews/Container.visible = true
	if bepis == false:
		$DailyNews/Container.visible = false
		
func _on_Area2D_body_entered(body):
	toggle = true

func _on_Area2D_body_exited(body):
	toggle = false
	
