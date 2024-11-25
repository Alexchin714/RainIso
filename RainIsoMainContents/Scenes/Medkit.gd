extends Spatial

func _on_HealthAdd_body_entered(body):
	CrossHallItems.hp += 1
	CrossHallItems.MedKits = true
	queue_free()
