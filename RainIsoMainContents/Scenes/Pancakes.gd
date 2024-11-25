extends Spatial

signal get_pancakes

func _ready():
	pass

func _on_Area_body_entered(body):
	emit_signal("get_pancakes")
	$Area/CollisionShape.call_deferred("set", "disabled", true)
	$AnimationPlayer.play("Collected")
	yield(get_tree().create_timer(2), "timeout")
	queue_free()
