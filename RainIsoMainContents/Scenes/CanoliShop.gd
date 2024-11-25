extends Node2D

func _ready():
	pass

func _on_Slot01_pressed():
	if Global.panera < 15: Global.panera -= 15

func _on_Slot02_pressed():
	if Global.panera < 250: Global.panera -= 250

func _on_Slot03_pressed():
	if Global.panera < 25: Global.panera -= 25

func _on_Slot04_pressed():
	if Global.panera < 50: Global.panera -= 50
