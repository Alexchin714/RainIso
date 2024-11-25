extends CanvasLayer

var toggle = false
onready var object_cursor = get_node("/root/EditorState/Editor_Objects")
onready var editor = get_node("/root/EditorState/CamContainer")
onready var editor_cam = editor.get_node("Camera2D")

func _process(delta):
	if Input.is_action_just_pressed("mb_right"):
		$TrashIcon/AnimationPlayer.play("glowup")
	if Input.is_action_just_released("mb_right"):
		$TrashIcon/AnimationPlayer.play_backwards("glowup")
		
func _on_AutoTiling_toggled(button_pressed):
	$TabContainer/C/ScrollContainer/VBoxContainer/HBoxContainer/ItemTiles5.visible = true
	$TabContainer/C/ScrollContainer/VBoxContainer/HBoxContainer/ItemTiles.visible = false


func _on_Snap_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()
	pass # Replace with function body.


func _on_Snap_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()
	pass # Replace with function body.


func _on_Swipe_pressed():
	pass # Replace with function body.


func _on_DeSelect_pressed():
	pass # Replace with function body.


func _on_Snap_pressed():
	pass # Replace with function body.


func _on_Button1_pressed():
	get_node("ManageInput/CreateSelectionIcon").modulate = Color(0,1,0)
	$TabContainer.visible = true
	$EditorControl.visible = true
	$ManageInput/Button1.visible = false
	$ManageInput/Button4.visible = true
	$ManageInput/Label4.visible = true
	$ManageInput/Label2.visible = false

func _on_Button3_pressed():
	get_node("ManageInput/ViewSelectionIcon").modulate = Color(0,1,0)
	$FileDialog.visible = true


func _on_Button4_pressed():
	$TabContainer.visible = false
	$EditorControl.visible = false
	$ManageInput/Button1.visible = true
	$ManageInput/Button4.visible = false
	$ManageInput/Label4.visible = false
	$ManageInput/Label2.visible = true

func _on_RotateButton_pressed():
	pass # Replace with function body.

func _on_Button2_pressed():
	get_node("ManageInput/EditSelectionIcon").modulate = Color(0,1,0)

func _on_Button5_pressed():
	pass # Replace with function body.

func _on_RoomAreaButton_pressed():
	$Control.visible = true

func _on_CloseButton_pressed():
	$Control.visible = false

func _on_Ground_pressed():
	$TabContainer.visible = true

func _on_ToggleButton_pressed():
	toggle = !toggle
	if toggle == true:
		$StyleCanvasItem/TabContainer/AnimationPlayer.play("open")
	if toggle == false:
		$StyleCanvasItem/TabContainer/AnimationPlayer.play_backwards("open")

func _on_ToggleButton_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()
	$StyleCanvasItem/TabContainer/StylePlayer.play("color")

func _on_ToggleButton_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()
	$StyleCanvasItem/TabContainer/StylePlayer.play_backwards("color")

func _on_TabContainer_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_TabContainer_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()


func _on_StyleTab_mouse_entered():
	pass # Replace with function body.


func _on_StyleTab_mouse_exited():
	pass # Replace with function body.

func _on_ItemTiles_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_ItemTiles_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()
