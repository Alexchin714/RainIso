extends Area2D

func _on_EngineTime_body_entered(body):
	Engine.time_scale = 0.25
