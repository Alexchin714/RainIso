extends Area2D

var easter = false

func _on_Referencer_body_entered(body):
	var fishani = get_owner().get_node("TileMap/ClementBoots/AnimationPlayer")
	if easter == true:
		fishani.play("ffeeezsssshghhhh")
		easter = false

func _on_DialogueArea26_easterfish():
	easter = true
