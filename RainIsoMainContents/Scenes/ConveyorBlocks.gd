extends Node2D

func _on_Area2D_body_entered(body):
	$AnimationPlayer.play("launch")
	$AnimationPlayerUse.play("used")
	$Timer.start()
	$Sprite/StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	$Sprite/Area2D/CollisionShape2D.set_deferred("disabled", true)
	if body.name == "Player":
		body.velocity.y = -700
		body.hasDashed = false
		body.move_and_slide(body.velocity)
	
func _on_Timer_timeout():
	$AnimationPlayerUse.play_backwards("used")
	$Sprite/Area2D/CollisionShape2D.set_deferred("disabled", false)
	$Sprite/StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
