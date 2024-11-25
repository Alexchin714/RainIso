extends Control

var settingsgd = preload("res://RainIsoMainContents/Scenes/Settings.gd")
var current_selection = 0
var optionused = false
var customused = false
var quitused = false

onready var settings = get_node("Settings")

func _ready():
	Music.mainshow.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Back_pressed():
	$AnimationPlayer.play_backwards("TransitionDown")
	optionused = false

func _on_StartUpScreen_start():
	$General/StartNode2D/StartButton.grab_focus()
	Global.NodeModList = $ModLists/Panel/ModList
	ModManager.preloadMods()

func _on_Start_mouse_entered():
	sound()
	$Buttons/Start/AnimationPlayer.play("hl")

func _on_Create_mouse_entered():
	sound()
	$Buttons/Create/AnimationPlayer.play("hl")

func _on_Settings_mouse_entered():
	sound()
	$Buttons/Settings/AnimationPlayer.play("hl")

func _on_Exit_mouse_entered():
	sound()
	$Buttons/Exit/AnimationPlayer.play("hl")

func _on_Start_pressed():
	sound02()
	SceneTransition.change_scene("res://RainIsoMainContents/Scenes/LevelSelectionScreen.tscn")

func _on_Create_pressed():
	sound02()
	$CreateScreen/AnimationPlayer.play("createactivation")

func _on_Start_mouse_exited():
	$Buttons/Start/AnimationPlayer.play_backwards("hl")

func _on_Create_mouse_exited():
	$Buttons/Create/AnimationPlayer.play_backwards("hl")

func _on_Settings_mouse_exited():
	$Buttons/Settings/AnimationPlayer.play_backwards("hl")

func _on_Exit_mouse_exited():
	$Buttons/Exit/AnimationPlayer.play_backwards("hl")

func _on_Settings_pressed():
	sound02()
	settings.openSettings()

func _on_Exit_pressed():
	sound02()
	get_tree().quit()

func sound():
	$Sounds/Sound.play()

func sound02():
	$Sounds/Sound02.play()

func _on_Button_pressed():
	$Textures/Background/colorSplash/AnimationPlayer.play("splash")

func _on_pB_pressed():
	$Textures/Background/pulseCircles/purple/AnimationPlayer.play("pulse")

func _on_gB_pressed():
	$Textures/Background/pulseCircles/green/AnimationPlayer.play("pulse")

func _on_bB_pressed():
	$Textures/Background/pulseCircles/blue/AnimationPlayer.play("pulse")

func _on_yB_pressed():
	$Textures/Background/pulseCircles/yellow/AnimationPlayer.play("pulse")

func _on_rB_pressed():
	$Textures/Background/pulseCircles/red/AnimationPlayer.play("pulse")
