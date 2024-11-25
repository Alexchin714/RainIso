extends Spatial

signal fastFoward
signal pause
signal reset
signal actualReset

var stopfastforward1 = false
var stopfastforward2 = false
var fastforward1 = false
var fastforward2 = false

var adder1 = false
var adder2 = false

var trigger1 = false
var trigger2 = false
var trigger3 = false

var illcam_toggle = false
var cam_toggle = false
var toggle = false
onready var player_cam = get_owner().get_node("3dPlayer/SpringArm/Camera")
onready var artifact_cam = get_owner().get_node("ArtifactPov")
onready var ani = get_node("AnimationPlayer")

func _process(delta):
	if Input.is_action_just_pressed("look_down"):
		cam_toggle = true
	if cam_toggle == true:
		cam_toggle = false
		$Camera.current = true
		player_cam.current = false
		artifact_cam.current = false
		$Camera/AnimationPlayer.play("cam_look")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("ui_cancel"):
		illcam_toggle = true
	if illcam_toggle == true:
		illcam_toggle = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		player_cam.current = true
	if trigger2:
		fastforward1 = true
	if trigger3:
		fastforward2 = true
	if fastforward1 == true:
		fastforward1 = false
		emit_signal("fastFoward")
	if fastforward2 == true:
		fastforward2 = false
		emit_signal("reset")
	if !trigger2 and !trigger3:
		emit_signal("actualReset")
	
func _on_Area_button_down():
	trigger1 = true
	$AnimationPlayer.play("pausePressed")

func _on_Area_button_up():
	trigger1 = false
	$AnimationPlayer.play_backwards("pausePressed")

func _on_Area2_button_down():
	trigger2 = true
	$AnimationPlayer2.play("fastfowardPressed")

func _on_Area2_button_up():
	trigger2 = false
	$AnimationPlayer2.play_backwards("fastfowardPressed")

func _on_Area3_button_down():
	trigger3 = true
	$AnimationPlayer3.play("resetPressed")

func _on_Area3_button_up():
	trigger3 = false
	$AnimationPlayer3.play_backwards("resetPressed")
