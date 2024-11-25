extends Spatial

func _on_Area_body_entered(body):
	$StonePillars/Area/CollisionShape.set_deferred("disabled", true)

func _on_Area_body_exited(body):
	$StonePillars/Area/CollisionShape.set_deferred("disabled", false)
