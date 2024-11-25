extends PopupMenu



func _on_Retry_pressed():
	pass # Replace with function body.


func _on_Exit_pressed():
	print("res://Level" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
	get_tree().change_scene("res://Level" + str(int(get_tree().current_scene.name) + 1))
