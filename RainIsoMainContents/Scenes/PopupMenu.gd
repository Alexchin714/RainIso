extends PopupMenu



func _on_ProfileButton_pressed():
	popup()


func _on_Yes_pressed():
	if get_node("/root/TitleScreen/CanvasLayer3/PopupMenu").is_visible():
		get_node("/root/TitleScreen/CanvasLayer3/PopupMenu").hide()
		get_node("/root/TitleScreen/UserProfile/CanvasLayer2/PopupMenu/ColorRect").show()

func _on_No_pressed():
	if get_node("/root/TitleScreen/CanvasLayer3/PopupMenu").is_visible():
		get_node("/root/TitleScreen/CanvasLayer3/PopupMenu").hide()


func _on_Button_pressed():
	pass # Replace with function body.
