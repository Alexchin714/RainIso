extends Node

onready var pancake_timer = OS.get_ticks_msec()

func pantime():
	var cur = OS.get_ticks_msec() - pancake_timer
	var shineSec = cur/1000%60
