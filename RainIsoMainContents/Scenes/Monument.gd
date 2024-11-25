extends Spatial

func _on_VisibilityNotifierMonument_camera_entered(camera):
	visible = true
	
func _on_VisibilityNotifierMonument_camera_exited(camera):
	visible = false
