extends Node2D

export var damage = 0;

onready var getPlayer = $"../Player"
onready var GrabNode = $"../Editor"

func hurt_player():
	getPlayer.hurt(damage)
	pass
	

func _on_DamageObject_body_entered(body):
	hurt_player()
	pass
