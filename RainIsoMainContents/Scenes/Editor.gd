extends Node2D

const COLUMNS = 7
const ROWS = 6

export var on = true

var grid_size = Vector2(8,8)
var grid = []

onready var editor = get_node("/root/EditorState/CamContainer")
onready var playernode = get_node("/root/EditorState/Player")
onready var editor_cam = editor.get_node("Camera2D")
onready var transitional_cam = playernode.get_node("TransitionalCamera2D")
onready var object_cursor = get_node("/root/EditorState/Editor_Objects")
var should_reset = false
export var Colorpalette_scene: PackedScene
var playerscene = load("res://RainIsoMainContents/Scenes/Player.tscn")
var player = playerscene.instance()
var mn
			
func _ready():
	$CamContainer/Camera2D.current = true
		
func _unhandled_input(event):
	pass
	
func _on_Colors_pressed():
	$EditorSpace.get_child(0).show()


func _on_EditorPauseButton_pressed():
	$EditorPause.get_child(0).show()


func _on_ActivateButton_pressed():
	pass # Replace with function body.


func _on_SaveAndPlay_pressed():
	$ThePlayer.visible = true
		
func _on_PlayTestButton_pressed():
	$CanvasLayer13/PlayTestButton.visible = false
	$CanvasLayer3/Colors.visible = false
	$CanvasLayer16/Life.visible = true
	$Player.visible = true
	$CanvasLayer13/RestartTestButton.visible = true
	$CanvasLayer15/ColorRect.visible = true
	$ItemSelectionScreen/TabContainer.visible = false
	$ItemSelectionScreen/EditorControl.visible = false
	transitional_cam.current = true
	
func _on_CheckButton_pressed():
	$CanvasLayer12/ParallaxBackground/ParallaxLayer3/BGLayer3.visible = false
	$CanvasLayer12/ParallaxBackground/ParallaxLayer3/BGLayer2.visible = false
	$CanvasLayer12/ParallaxBackground/ParallaxLayer3/BGLayer1.visible = false
	$CanvasLayer12/ParallaxBackground/ParallaxLayer3/BGLayerFiller.visible = false


func _on_RestartTestButton_pressed():
	$CanvasLayer13/ReplayTestButton.visible = false
	$CanvasLayer13/PlayTestButton.visible = true
	$CanvasLayer/EditorPauseButton.visible = true
	$CanvasLayer3/Colors.visible = true
	$CanvasLayer16/Life.visible = false
	add_child(player)
	$Player.visible = false
	$CanvasLayer13/RestartTestButton.visible = false
	$CanvasLayer15/ColorRect.visible = false
	$ItemSelectionScreen/TabContainer.visible = true
	$ItemSelectionScreen/EditorControl.visible = true
	get_tree().reload_current_scene()
	editor_cam.current = true
	
func _on_RestartTestButton_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()


func _on_RestartTestButton_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()
	pass # Replace with function body.


func _on_PlayTestButton_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()


func _on_PlayTestButton_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()
	pass # Replace with function body.


func _on_ColorRect_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()


func _on_ColorRect_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()
	pass # Replace with function body.
	
func reset():
	should_reset = false

func _on_EditorPauseButton_mouse_entered():
	$CanvasLayer/AnimationPlayerGlowUp.play("GlowUP")
	
func _on_EditorPauseButton_mouse_exited():
	$CanvasLayer/AnimationPlayerGlowUp.play("GlowDOWN")



func _on_BGButtonActualButton_pressed():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.handle_death()

func _on_RoomButton_pressed():
	$CameraEditorMaker/Camera2D6.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_RoomButton2_pressed():
	$CameraEditorMaker/Camera2D1.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_RoomButton3_pressed():
	$CameraEditorMaker/Camera2D2.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_RoomButton4_pressed():
	$CameraEditorMaker/Camera2D3.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_RoomButton5_pressed():
	$CameraEditorMaker/Camera2D5.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_RoomButton6_pressed():
	$CameraEditorMaker/Camera2D7.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_RoomButton7_pressed():
	$CameraEditorMaker/Camera2D9.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_RoomButton8_pressed():
	$CameraEditorMaker/Camera2D10.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_RoomButton9_pressed():
	$CameraEditorMaker/Camera2D11.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_RoomButton10_pressed():
	$CameraEditorMaker/Camera2D13.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_RoomButton12_pressed():
	$CameraEditorMaker/Camera2D15.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_RoomButton13_pressed():
	$CameraEditorMaker/Camera2D4.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_RoomButton15_pressed():
	$CameraEditorMaker/Camera2D12.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_RoomButton16_pressed():
	$CameraEditorMaker/Camera2D16.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_RoomButton14_pressed():
	$CameraEditorMaker/Camera2D8.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_RoomButton11_pressed():
	$CameraEditorMaker/Camera2D14.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_CloseButton_pressed():
	$Control.visible = false

func _on_FreeRoamIcon_pressed():
	editor_cam.current = true
	$ItemSelectionScreen/Control.visible = false


func _on_HSlider_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_HSlider_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()
