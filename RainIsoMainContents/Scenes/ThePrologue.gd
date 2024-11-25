extends Node2D

onready var editor = get_node("/root/Editor/CamContainer")
onready var playernode = get_node("/root/Editor/Player")
onready var transitional_cam = playernode.get_node("TransitionalCamera2D")
onready var freeroam_cam = playernode.get_node("FreeRoamCamera2D")
onready var object_cursor = get_node("/root/Editor/Editor_Objects")
var should_reset = false
export var Colorpalette_scene: PackedScene
var playerscene = load("res://RainIsoMainContents/Scenes/Player.tscn")
var player = playerscene.instance()
var mn

func _ready():
	$Level.visible = true
	transitional_cam.current = true
	
func _unhandled_input(event):
	pass
	
func _on_Colors_pressed():
	$Colors.get_child(0).show()


func _on_EditorPauseButton_pressed():
	$EditorPause.get_child(0).show()


func _on_ActivateButton_pressed():
	pass # Replace with function body.


func _on_SaveAndPlay_pressed():
	$ThePlayer.visible = true
	
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
		body.isDead()
	
func _on_StartTimer_timeout():
	transitional_cam.current = true

func _on_Timer_timeout():
	$Level.visible = true

func _on_LavaHillTransition1_body_entered(body):
	$CamContainer/ParallaxBackground/LavaBG1.visible = true
	$CamContainer/ParallaxBackground/LavaHillBG2.visible = true
	$CamContainer/ParallaxBackground/LavaHillBG3.visible = false
	$CamContainer/ParallaxBackground/LavaHillBG4.visible = false
	$CamContainer/ParallaxBackground/LavaHillBG5.visible = false
	$CamContainer/ParallaxBackground/LavaHillBG6.visible = false
	$LavaHillTransition/AnimationPlayer.play("Fade")
	
func _on_LavaHillTransition2_body_entered(body):
	$CamContainer/ParallaxBackground/LavaBG1.visible = false
	$CamContainer/ParallaxBackground/LavaHillBG2.visible = false
	$CamContainer/ParallaxBackground/LavaHillBG3.visible = true
	$CamContainer/ParallaxBackground/LavaHillBG4.visible = true
	$CamContainer/ParallaxBackground/LavaHillBG5.visible = true
	$CamContainer/ParallaxBackground/LavaHillBG6.visible = true
	$LavaHillTransition/AnimationPlayer.play("Fade")

func _on_LavaHillTransition3_body_entered(body):
	$CamContainer/ParallaxBackground/LavaBG1.visible = false
	$CamContainer/ParallaxBackground/LavaHillBG2.visible = false
	$CamContainer/ParallaxBackground/LavaHillBG3.visible = true
	$CamContainer/ParallaxBackground/LavaHillBG4.visible = true
	$CamContainer/ParallaxBackground/LavaHillBG5.visible = true
	$CamContainer/ParallaxBackground/LavaHillBG6.visible = true

func _on_FreeRoamEnter_body_entered(body):
	transitional_cam.current = false
	freeroam_cam.current = true

func _on_TransitionalEnter_body_entered(body):
	transitional_cam.current = true
	freeroam_cam.current = false

func _on_EndLevel_body_entered(body):
	$ChapterComplete/Control/AnimationPlayer.play("ChapterCompleteScreen")
	$ChapterComplete/Control/Timer.start()

func _on_PrologueTransition_body_entered(body):
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/LevelSelectionScreen.tscn")
