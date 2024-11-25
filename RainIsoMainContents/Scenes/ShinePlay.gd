extends Control

signal startShine

func _on_TextureButton_pressed():
	$AnimationPlayer.play_backwards("play")
	yield(get_tree().create_timer(1.1), "timeout")
	self.visible = false
	emit_signal("startShine")

func _on_TextureButton2_pressed():
	$AnimationPlayer.play_backwards("play")
	yield(get_tree().create_timer(1.1), "timeout")
	self.visible = false
