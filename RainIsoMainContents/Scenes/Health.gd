extends Node2D

func _ready():
	HealthCounter.lives=1
	
func _physics_process(delta):
	if HealthCounter.lives == 1:
		$Lives.hide()
