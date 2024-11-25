extends Node2D

onready var editor = get_node("/root/Editor/CamContainer")
onready var playernode = get_node("/root/Editor/Player")
onready var editor_cam = editor.get_node("Camera2D")
onready var object_cursor = get_node("/root/Editor/Editor_Objects")
var should_reset = false
export var Colorpalette_scene: PackedScene
var playerscene = load("res://RainIsoMainContents/Scenes/Player.tscn")
var player = playerscene.instance()
var mn

func _ready():
	pass
	#var map_with_visible_notifier = load("res://RainIsoMainContents/Scenes/LTileMap.tscn")
#	var map_size = 1
	#var chunk_size = 1
	
#	for chunk_x in range(map_size / chunk_size):
	#	for chunk_y in range(map_size / chunk_size):
		#	var map_c = map_with_visible_notifier.instance()
		#	map_c.chunk_rect.position = Vector2(chunk_size * chunk_x, chunk_size * chunk_y)
		#	map_c.chunk_rect.size = Vector2(chunk_size, chunk_size)
		#	for x in range(chunk_size):
			#	for y in range(chunk_size):
			#		map_c.set_cell(map_c.chunk_rect.position.x + x, map_c.chunk_rect.position.y + y, chunk_x + chunk_y)
		#	add_child(map_c)	
#func get_Tilemap(pos):
	#var tilemaps = get_tree().get_nodes_in_group("map")
	#for map in tilemaps:
	#	if map.chunk_rect.has_point(pos):
		#	return map
	#return null


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.isDead()

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
