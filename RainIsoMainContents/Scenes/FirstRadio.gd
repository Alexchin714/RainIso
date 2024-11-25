extends Control

onready var valbl = $Panel/NumPanel/ValueLabel
var radionum = 0

func _process(delta):
	valbl.text = str(radionum)

func _on_ValueSlider_value_changed(value):
	radionum = value
