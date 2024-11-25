extends Node2D

onready var player = get_node("../Player")
onready var letter = $Sprite
var speed = 0.1

func _process(delta):
	$Sprite.global_position = $Sprite.global_position.linear_interpolate(player.global_position,speed)
