extends Spatial

signal get_coin

func _ready():
	$AnimationPlayer.play("Idle")

func _on_Area_body_entered(body):
	$Area/CollisionShape.call_deferred("set", "disabled", true)
	$AnimationPlayer.play("Collected")
	emit_signal("get_coin")
	yield(get_tree().create_timer(1.1), "timeout")
	queue_free()
