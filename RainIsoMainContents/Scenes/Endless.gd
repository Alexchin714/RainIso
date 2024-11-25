extends Node2D

func _init():
	randomize()
	var screenSize: Vector2 = OS.get_screen_size()
	var windowSize: Vector2 = OS.get_window_size()
	
	OS.set_window_position(screenSize * 0.5 - windowSize * 0.5)
