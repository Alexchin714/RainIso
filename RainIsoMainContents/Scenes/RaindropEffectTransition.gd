extends CanvasLayer
	
func change_scene(target: String) -> void:
	$AnimationPlayer.play("SceneChanged")
	yield($AnimationPlayer,'animation_finished')
	get_tree().change_scene(target)
	$AnimationPlayer.play_backwards("SceneChanged")
