extends Node2D

func _ready():
	pass

func _on_ColorPickerButton_color_changed(color):

	material.set("shader_param/NEWCOLOR1",color)
	pass # Replace with function body.
