extends Node2D

func _on_Area2D_body_entered(body):
	$AnimationPlayer.play("Queue_free")
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	
func _on_Timer_timeout():
	queue_free()
