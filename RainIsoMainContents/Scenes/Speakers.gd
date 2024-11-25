extends Node2D

func _on_Lefttouch_body_entered(body):
	$AnimationPlayer.play("SpeakerBlast")
	if body.name == "Player":
		body.velocity.x = -3000
		body.move_and_slide(body.velocity)
		$Timer.start()
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		$AreaEnter/CollisionShape2D.set_deferred("disabled", true)
		$Lefttouch/CollisionShape2D.set_deferred("disabled", true)
		$Righttouch/CollisionShape2D.set_deferred("disabled", true)
		
func _on_Righttouch_body_entered(body):
	$AnimationPlayer.play("SpeakerBlast")
	if body.name == "Player":
		body.velocity.x = 3000
		body.move_and_slide(body.velocity)
		$Timer.start()
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		$AreaEnter/CollisionShape2D.set_deferred("disabled", true)
		$Lefttouch/CollisionShape2D.set_deferred("disabled", true)
		$Righttouch/CollisionShape2D.set_deferred("disabled", true)
		
func _on_Timer_timeout():
	$AnimationPlayer.play_backwards("SpeakerBlast")
	$Lefttouch/CollisionShape2D.set_deferred("disabled", true)
	$Righttouch/CollisionShape2D.set_deferred("disabled", true)
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	$AreaEnter/CollisionShape2D.set_deferred("disabled", false)
	
func _on_AreaEnter_body_entered(body):
	if body.name == "Player":
		if body.isDashing:
			$Lefttouch/CollisionShape2D.set_deferred("disabled", false)
			$Righttouch/CollisionShape2D.set_deferred("disabled", false)
