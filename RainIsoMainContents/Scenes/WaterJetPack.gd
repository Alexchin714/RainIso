extends Node2D

onready var postween = get_node("Tween")
	
func _on_Area2D_body_entered(body):
	$AnimationPlayer.play("STATE1")
	if body.name == "Player":
		body.hasDashed = false
		body.isJetpacking = true
		body.hasJetPack = true
		body.FUEL = 100
		$JetpackAnimationPlayer.play("used")
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		yield(get_tree().create_timer(3), "timeout")
		$JetpackAnimationPlayer.play_backwards("used")
		$Area2D/CollisionShape2D.set_deferred("disabled", false)
