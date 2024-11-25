extends CanvasLayer

onready var object_cursor = get_node("/root/EditorState/Editor_Objects")
var active = false

func _on_ThemeButton_pressed():
	active = true
	$Panel/AnimationPlayer.play("background")

func _process(delta):
	if Input.is_action_just_pressed("esc") and active == true:
		active = false
		$Panel/AnimationPlayer.play_backwards("background")

func _on_BackButton_pressed():
	active = false
	$Panel/AnimationPlayer.play_backwards("background")

func _on_Panel_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_Panel_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_MelodyTownIcon_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_NeoRushIcon_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_LavaHillIcon_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_BackButton_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_MelodyTownIcon_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_NeoRushIcon_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_LavaHillIcon_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_BackButton_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()
