extends Node2D

onready var timer = $Timer

func startDash(dur):
	timer.wait_time = dur
	timer.start()
	
func is_dashing():
	return !timer.is_stopped()
