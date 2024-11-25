extends PopupMenu



func _on_ExitButton_toggled(button_pressed):
	popup()


func _on_CancelButton_pressed():
	$PopUpMenu.visible = false
