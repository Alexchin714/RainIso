extends Area2D

signal check

var active: bool = false

func _ready():
	$Sprite.visible = false
	
func _on_Checkpoints_player_entered(player: KinematicBody2D):
	if not active:
		player.last_checkpoint = self
		active = true
		Global.checkpoint = true
