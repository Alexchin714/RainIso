extends MarginContainer

func _physics_process(delta):
	$FPSCounter.text = "FPS: " + str(Performance.get_monitor(Performance.TIME_FPS))

