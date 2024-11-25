extends Node

signal enviromental_lighting(value)

func enviromentalLighting(value):
	emit_signal("enviromental_lighting", value)
	SaveSettings.game_data.display_fps = value
	SaveSettings.save_data()
