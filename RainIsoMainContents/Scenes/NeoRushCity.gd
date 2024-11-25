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
	var map_with_visible_notifier = load("res://RainIsoMainContents/Scenes/NTileMap.tscn")
	var map_size = 1
	var chunk_size = 1
	
	for chunk_x in range(map_size / chunk_size):
		for chunk_y in range(map_size / chunk_size):
			var map_c = map_with_visible_notifier.instance()
			map_c.chunk_rect.position = Vector2(chunk_size * chunk_x, chunk_size * chunk_y)
			map_c.chunk_rect.size = Vector2(chunk_size, chunk_size)
			for x in range(chunk_size):
				for y in range(chunk_size):
					map_c.set_cell(map_c.chunk_rect.position.x + x, map_c.chunk_rect.position.y + y, chunk_x + chunk_y)
			add_child(map_c)
		
	$Level.visible = true
	$Timer.start()
	$AmbientMusic.play()
	transitional_cam.current = true
	
func get_Tilemap(pos):
	var tilemaps = get_tree().get_nodes_in_group("map")
	for map in tilemaps:
		if map.chunk_rect.has_point(pos):
			return map
	return null
	
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
