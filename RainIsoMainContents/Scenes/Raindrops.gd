extends Node2D

export var raindropEffect = 0
export var scene : String

func rainScene():
	pass

func _on_Area2D_body_entered(body):
	rainScene()
	Music.stop()
