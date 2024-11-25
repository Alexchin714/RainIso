extends Node2D

func _on_RoomBoundaries_body_entered(body):
	$MoxieCarnival/AnimationPlayer.play("carnival")
