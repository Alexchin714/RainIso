extends Area2D

var player

func _ready():
	player = get_parent().get_node("Player")
	
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			var vector = position-player.position
			player.velocity += vector/10
