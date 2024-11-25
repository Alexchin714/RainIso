extends Node

onready var ambiance1 = get_parent().get_node("Audio/Ambience01")
onready var ambiance2 = get_parent().get_node("Audio/Ambience02")

func _on_JourneyStepArea_body_entered(body):
	#Music.backhigh()
	#Music.journeystep.play()
	pass

func _on_JourneyStepArea_body_exited(body):
#	Music.journeystep.stop()
	pass
