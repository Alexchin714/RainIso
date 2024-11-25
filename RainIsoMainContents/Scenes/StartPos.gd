extends Area2D

var destination

func _ready():
	destination = get_node("Player").get_global_position()
