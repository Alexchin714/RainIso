extends Node2D

const COLUMNS = 7
const ROWS = 6

export var on = true

var toggle = false

var grid_size = Vector2(8,8)
var grid = []

var editortoggle = false

signal EditorMode
signal PlayMode

onready var tbg = get_node("Audio/TheBeginning")
onready var js = get_node("Audio/JourneyStep")
onready var ds = get_node("Audio/DarkStep")
onready var ef = get_node("Audio/ElectroFrog")
onready var nrf = get_node("Audio/NeoReflections")
onready var ls = get_node("Audio/LavaStep")
onready var ang = get_node("Audio/Anguish")
onready var lacamp = get_node("Audio/LaCampanoux")
onready var cog = get_node("Audio/Cognitize")
onready var drf = get_node("Audio/DarkReflections")
onready var dhe = get_node("Audio/DiamondHeartEmerald")
onready var tcod = get_node("Audio/TheCheerOfDays")
onready var tnd = get_node("Audio/TheNumberingDays")
onready var hd = get_node("Audio/HappiestDays")
onready var ca = get_node("Audio/CultistAscent")

onready var editor = get_node("CamContainer")
onready var playernode = get_node("/root/EditorState/PlayViewport/Player")
onready var editor_cam = editor.get_node("Camera2D")
onready var object_cursor = get_node("/root/EditorState/Editor_Objects")

onready var melody = [$BackgroundDefault/container/melody/bg_01, $BackgroundDefault/container/melody/bg_02, $BackgroundDefault/container/melody/bg_03]
onready var neorush = [$BackgroundDefault/container/neorush/bg_01, $BackgroundDefault/container/neorush/bg_02, $BackgroundDefault/container/neorush/bg_03]
onready var lavahill = [$BackgroundDefault/container/lavahill/bg_01, $BackgroundDefault/container/lavahill/bg_02]

var nmb = 0
var should_reset = false
var styleground = false
export var Colorpalette_scene: PackedScene
var playerscene = load("res://RainIsoMainContents/Scenes/Player.tscn")
var player = playerscene.instance()
var mn
			
func _ready():
	$PlayButton/Pause.grab_focus()
	$Player.set_physics_process(false)
	$Player.set_process_input(false)
	editor_cam.current = true
		
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


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.isDead()


func _on_FreeRoamIcon_pressed():
	editor_cam.current = true
	$ItemSelectionScreen/Control.visible = false

func _on_HSlider_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_HSlider_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_Pause_pressed():
	$EditorPause.get_child(0).show()

func _on_Space_pressed():
	$EditorSpace.get_child(0).show()
	$EditorSpace/Control/AnimationPlayer.play("transition")

func _on_MelodyTownIcon_pressed():
	$CamContainer/ParallaxBackground/MelodyTownBG1.show()
	$CamContainer/ParallaxBackground/MelodyTownBGLayer2.show()
	$CamContainer/ParallaxBackground/MelodyTownBGLayer1.show()
	$CamContainer/ParallaxBackground/NeoRushCity.hide()
	$CamContainer/ParallaxBackground/NeoRushCity2.hide()
	$CamContainer/ParallaxBackground/NeoRushCity3.hide()
	$CamContainer/ParallaxBackground/NeoRushCity4.hide()
	$CamContainer/ParallaxBackground/NeoRushCity5.hide()
	$CamContainer/ParallaxBackground/NeoRushCity5.hide()
	$CamContainer/ParallaxBackground/LavaHill.hide()
	$CamContainer/ParallaxBackground/LavaHill2.hide()
	$CamContainer/ParallaxBackground/LavaHill3.hide()
	$CamContainer/ParallaxBackground/LavaHill4.hide()

func _on_NeoRushIcon_pressed():
	$CamContainer/ParallaxBackground/MelodyTownBG1.hide()
	$CamContainer/ParallaxBackground/MelodyTownBGLayer2.hide()
	$CamContainer/ParallaxBackground/MelodyTownBGLayer1.hide()
	$CamContainer/ParallaxBackground/NeoRushCity.show()
	$CamContainer/ParallaxBackground/NeoRushCity2.show()
	$CamContainer/ParallaxBackground/NeoRushCity3.show()
	$CamContainer/ParallaxBackground/NeoRushCity4.show()
	$CamContainer/ParallaxBackground/NeoRushCity5.show()
	$CamContainer/ParallaxBackground/NeoRushCity5.show()
	$CamContainer/ParallaxBackground/LavaHill.hide()
	$CamContainer/ParallaxBackground/LavaHill2.hide()
	$CamContainer/ParallaxBackground/LavaHill3.hide()
	$CamContainer/ParallaxBackground/LavaHill4.hide()

func _on_LavaHillIcon_pressed():
	$CamContainer/ParallaxBackground/MelodyTownBG1.hide()
	$CamContainer/ParallaxBackground/MelodyTownBGLayer2.hide()
	$CamContainer/ParallaxBackground/MelodyTownBGLayer1.hide()
	$CamContainer/ParallaxBackground/NeoRushCity.hide()
	$CamContainer/ParallaxBackground/NeoRushCity2.hide()
	$CamContainer/ParallaxBackground/NeoRushCity3.hide()
	$CamContainer/ParallaxBackground/NeoRushCity4.hide()
	$CamContainer/ParallaxBackground/NeoRushCity5.hide()
	$CamContainer/ParallaxBackground/NeoRushCity5.hide()
	$CamContainer/ParallaxBackground/LavaHill.show()
	$CamContainer/ParallaxBackground/LavaHill2.show()
	$CamContainer/ParallaxBackground/LavaHill3.show()
	$CamContainer/ParallaxBackground/LavaHill4.show()

func _on_InfoButton_pressed():
	$PanelLayer/EntityObjectPanel.visible = false
	$AnimationPlayerState.play("InfoPressedShow")

func _on_Button_pressed():
	$AnimationPlayerState.play_backwards("InfoPressedShow")

func _on_ObjectButton_pressed():
	$PanelLayer/EntityObjectPanel.visible = true

func _on_XButton_pressed():
	$PanelLayer/EntityObjectPanel.visible = false

func _on_PlayButton_toggled(button_pressed):
	$Player.visible = button_pressed
	if $CamContainer/Camera2D.is_current():
		$CamContainer/Camera2D.clear_current()
		$Player/TransitionalCamera2D.make_current()
	elif $Player/TransitionalCamera2D.is_current():
		$Player/TransitionalCamera2D.clear_current()
		$CamContainer/Camera2D.make_current()
	$PlayViewport/Character.visible = button_pressed
	$Player.set_physics_process(true)
	$Player.position = Room.spawn_point
	
func _on_LightingButton_toggled(button_pressed):
	$Level/EnviromentalLighting.visible = button_pressed
	TheEditorSettings.enviromentalLighting(button_pressed)

func _on_RoomManagmentButton_pressed():
	$RoomManager/Panel.visible = !$RoomManager/Panel.visible

func _on_StyleGroundButton_pressed():
	$StyleGround/AnimationPlayer.play("down")

func _on_FileDialog_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_FileDialog_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_OptionButton_item_selected(index):
	pass

func _on_DiscButton_item_selected(index):
	if index == 0:
		tbg.play()
		js.stop()
		ds.stop()
		ef.stop()
		nrf.stop()
		ls.stop()
		ang.stop()
		lacamp.stop()
		cog.stop()
		drf.stop()
		dhe.stop()
		tcod.stop()
		tnd.stop()
		hd.stop()
		ca.stop()
	if index == 1:
		tbg.stop()
		js.play()
		ds.stop()
		ef.stop()
		nrf.stop()
		ls.stop()
		ang.stop()
		lacamp.stop()
		cog.stop()
		drf.stop()
		dhe.stop()
		tcod.stop()
		tnd.stop()
		hd.stop()
		ca.stop()
	if index == 2:
		tbg.stop()
		js.stop()
		ds.play()
		ef.stop()
		nrf.stop()
		ls.stop()
		ang.stop()
		lacamp.stop()
		cog.stop()
		drf.stop()
		dhe.stop()
		tcod.stop()
		tnd.stop()
		hd.stop()
		ca.stop()
	if index == 3:
		tbg.stop()
		js.stop()
		ds.stop()
		ef.play()
		nrf.stop()
		ls.stop()
		ang.stop()
		lacamp.stop()
		cog.stop()
		drf.stop()
		dhe.stop()
		tcod.stop()
		tnd.stop()
		hd.stop()
		ca.stop()
	if index == 4:
		tbg.stop()
		js.stop()
		ds.stop()
		ef.stop()
		nrf.play()
		ls.stop()
		ang.stop()
		lacamp.stop()
		cog.stop()
		drf.stop()
		dhe.stop()
		tcod.stop()
		tnd.stop()
		hd.stop()
		ca.stop()
	if index == 5:
		tbg.stop()
		js.stop()
		ds.stop()
		ef.stop()
		nrf.stop()
		ls.play()
		ang.stop()
		lacamp.stop()
		cog.stop()
		drf.stop()
		dhe.stop()
		tcod.stop()
		tnd.stop()
		hd.stop()
		ca.stop()
	if index == 6:
		tbg.stop()
		js.stop()
		ds.stop()
		ef.stop()
		nrf.stop()
		ls.stop()
		ang.play()
		lacamp.stop()
		cog.stop()
		drf.stop()
		dhe.stop()
		tcod.stop()
		tnd.stop()
		hd.stop()
		ca.stop()
	if index == 7:
		tbg.stop()
		js.stop()
		ds.stop()
		ef.stop()
		nrf.stop()
		ls.stop()
		ang.stop()
		lacamp.play()
		cog.stop()
		drf.stop()
		dhe.stop()
		tcod.stop()
		tnd.stop()
		hd.stop()
		ca.stop()
	if index == 8:
		tbg.stop()
		js.stop()
		ds.stop()
		ef.stop()
		nrf.stop()
		ls.stop()
		ang.stop()
		lacamp.stop()
		cog.play()
		drf.stop()
		dhe.stop()
		tcod.stop()
		tnd.stop()
		hd.stop()
		ca.stop()
	if index == 9:
		tbg.stop()
		js.stop()
		ds.stop()
		ef.stop()
		nrf.stop()
		ls.stop()
		ang.stop()
		lacamp.stop()
		cog.stop()
		drf.play()
		dhe.stop()
		tcod.stop()
		tnd.stop()
		hd.stop()
		ca.stop()
	if index == 10:
		tbg.stop()
		js.stop()
		ds.stop()
		ef.stop()
		nrf.stop()
		ls.stop()
		ang.stop()
		lacamp.stop()
		cog.stop()
		drf.stop()
		dhe.play()
		tcod.stop()
		tnd.stop()
		hd.stop()
		ca.stop()
	if index == 11:
		tbg.stop()
		js.stop()
		ds.stop()
		ef.stop()
		nrf.stop()
		ls.stop()
		ang.stop()
		lacamp.stop()
		cog.stop()
		drf.stop()
		dhe.stop()
		tcod.play()
		tnd.stop()
		hd.stop()
		ca.stop()
	if index == 12:
		tbg.stop()
		js.stop()
		ds.stop()
		ef.stop()
		nrf.stop()
		ls.stop()
		ang.stop()
		lacamp.stop()
		cog.stop()
		drf.stop()
		dhe.stop()
		tcod.stop()
		tnd.play()
		hd.stop()
		ca.stop()
	if index == 13:
		tbg.stop()
		js.stop()
		ds.stop()
		ef.stop()
		nrf.stop()
		ls.stop()
		ang.stop()
		lacamp.stop()
		cog.stop()
		drf.stop()
		dhe.stop()
		tcod.stop()
		tnd.stop()
		hd.play()
		ca.stop()
	if index == 14:
		tbg.stop()
		js.stop()
		ds.stop()
		ef.stop()
		nrf.stop()
		ls.stop()
		ang.stop()
		lacamp.stop()
		cog.stop()
		drf.stop()
		dhe.stop()
		tcod.stop()
		tnd.stop()
		hd.stop()
		ca.play()

func _on_EditorToggle_pressed():
	editortoggle = !editortoggle

func _on_Space_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_Space_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_Pause_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_Pause_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_PlayButton_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_PlayButton_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_DiscButton_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_DiscButton_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_Save_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_Save_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_Load_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_Load_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_Export_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_Export_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_Continue_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_Continue_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_Exit_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_Exit_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func InEditMode():
	emit_signal("EditorMode")
	
func InPlayMode():
	emit_signal("PlayMode")

func _on_PlayButton_pressed():
	toggle = !toggle
	if toggle == true:
		$PlayPlayer.play("close-open")
		InPlayMode()
	elif toggle == false:
		$PlayPlayer.play_backwards("close-open")
		InEditMode()

func _on_ZoomIn_pressed():
	$CamContainer/Camera2D.zoom.x -= 0.1
	$CamContainer/Camera2D.zoom.y -= 0.1

func _on_ZoomOut_pressed():
	$CamContainer/Camera2D.zoom.x += 0.1
	$CamContainer/Camera2D.zoom.y += 0.1

func _on_ZoomIn_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_ZoomIn_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_ZoomOut_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_ZoomOut_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_Panel_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_Panel_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_ZoomSlider_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_ZoomSlider_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_Top_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_Top_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_Icon_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_Icon_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_PanelSide_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()

func _on_PanelSide_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()

func _on_Styleground_pressed():
	styleground = !styleground
	$StyleGround/AnimationPlayer.play("down")

func visibleSelector():
	for Nb in melody:
		get_node(Nb).hide()
	for Nb in neorush:
		get_node(Nb).visible = nmb >= 2
	for Nb in lavahill:
		get_node(Nb).visible = nmb >= 3
	
func _on_melody_pressed():
	$BackgroundDefault/container_.visible = false
	#cont
	$BackgroundDefault/container/melody/bg_01.visible = true
	$BackgroundDefault/container/melody/bg_02.visible = true
	$BackgroundDefault/container/melody/bg_03.visible = true
	#melody
	$BackgroundDefault/container/neorush/bg_01.visible = false
	$BackgroundDefault/container/neorush/bg_02.visible = false
	$BackgroundDefault/container/neorush/bg_03.visible = false
	#neorush
	$BackgroundDefault/container/lavahill/bg_01.visible = false
	$BackgroundDefault/container/lavahill/bg_02/.visible = false

func _on_neorush_pressed():
	$BackgroundDefault/container_.visible = false
	#cont
	$BackgroundDefault/container/melody/bg_01.visible = false
	$BackgroundDefault/container/melody/bg_02.visible = false
	$BackgroundDefault/container/melody/bg_03.visible = false
	#melody
	$BackgroundDefault/container/neorush/bg_01.visible = true
	$BackgroundDefault/container/neorush/bg_02.visible = true
	$BackgroundDefault/container/neorush/bg_03.visible = true
	#neorush
	$BackgroundDefault/container/lavahill/bg_01.visible = false
	$BackgroundDefault/container/lavahill/bg_02/.visible = false

func _on_lavahill_pressed():
	$BackgroundDefault/container_.visible = false
	#cont
	$BackgroundDefault/container/melody/bg_01.visible = false
	$BackgroundDefault/container/melody/bg_02.visible = false
	$BackgroundDefault/container/melody/bg_03.visible = false
	#melody
	$BackgroundDefault/container/neorush/bg_01.visible = false
	$BackgroundDefault/container/neorush/bg_02.visible = false
	$BackgroundDefault/container/neorush/bg_03.visible = false
	#neorush
	$BackgroundDefault/container/lavahill/bg_01.visible = true
	$BackgroundDefault/container/lavahill/bg_02/.visible = true

func _on_melodyotherside_pressed():
	pass # Replace with function body.

func _on_neorushotherside_pressed():
	pass # Replace with function body.

func _on_lavahillotherside_pressed():
	pass # Replace with function body.
