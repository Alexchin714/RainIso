extends CanvasLayer

var optionsOpen = false
var focusToggle = false
var toggle = false
var audiodb = false
var mute = false
var finishedAnimation = false
var focus = 0
onready var plscript = get_owner().get_node("Player")
onready var settings = get_owner().get_node("Settings")
onready var animation1 = get_node("Main/AnimationPlayer01")
onready var animation2 = get_node("Main/AnimationPlayer02")
onready var animation3 = get_node("Main/AnimationPlayer03")
onready var animation4 = get_node("Main/AnimationPlayer04")
onready var animation5 = get_node("Main/AnimationPlayer05")
onready var animation6 = get_node("Main/AnimationPlayer06")

onready var audio01 = get_node("AudioStreamPlayer02")

const MusicBus = "Music"

func _ready():
	GlobalSettings.connect("mutewithPause", self, "muteWithPause")
	GlobalSettings.connect("sdPauseBg", self, "showPauseBg")
	GlobalSettings.connect("sdPauseText", self, "showPauseTxt")
	
func _input(event):
	if event.is_action_pressed("esc"):
		if !settings.back == true and settings.isInSettings == false:
			get_tree().paused = !get_tree().paused
			focusToggle = true
			audiodb = !audiodb
			toggle = !toggle
			$Main.visible = !$Main.visible
			focus = 0
			if toggle:
				Music.lower()
			else:
				Music.backhigh()
				$Main/ExitPlayer.play("exit")
	
func _on_ContinueButton_pressed():
	if !optionsOpen:
		$Main/ExitPlayer.play("exit")
		$Main.visible = false
		$AudioStreamPlayer.play()
		toggle = false
		Music.backhigh()
		focus = 0
		get_tree().paused = false

func _on_MainMenu_pressed():
	if !optionsOpen:
		$Main/ExitPlayer.play("exit")
		$Main.visible = false
		$AudioStreamPlayer.play()
		get_tree().paused = false
		get_tree().quit()
		focus = 0
		SceneTransition.change_scene("res://RainIsoMainContents/Scenes/TitleScreen.tscn")

func _on_RestartButton_pressed():
	if !optionsOpen:
		$Main/ExitPlayer.play("exit")
		Cutscene.cutscene = false
		$Main.visible = false
		$AudioStreamPlayer.play()
		get_tree().paused = false
		toggle = false
		Music.backhigh()
		focus = 0
		plscript.isDead()

func _on_ReturnToLastButton_pressed():
	#$Background.visible = false
	#$Main.visible = false
	#$AudioStreamPlayer.play()
	#get_tree().paused = false
	#SceneTransition.change_scene("res://RainIsoMainContents/Scenes/LevelSelectionScreen.tscn")
	pass
	
func _on_SettingsButton_pressed():
	if !optionsOpen:
		$Main/ExitPlayer.play("exit")
		$AudioStreamPlayer.play()
		settings.isInSettings = true
		settings.openSettings()
		focus = 0

func _on_SaveButton_pressed():
	if !optionsOpen:
		$Main/ExitPlayer.play("exit")
		LoadSaveComplete.completeSave()
		Global.checkpoint = true
		$Main.visible = false
		$AudioStreamPlayer.play()
		toggle = false
		Music.backhigh()
		get_tree().paused = false
		focus = 0

func _on_ContinueButton_focus_entered():
	animation1.play("cb")

func _on_RestartButton_focus_entered():
	animation2.play("rb")

func _on_SaveButton_focus_entered():
	animation3.play("sb")

func _on_ReturnToLastButton_focus_entered():
	animation4.play("rtlb")

func _on_SettingsButton_focus_entered():
	animation5.play("seb")

func _on_MainMenu_focus_entered():
	animation6.play("mm")

func showPauseBg(value):
	$Main/Background.visible = value
	
func showPauseTxt(value):
	$Main/Text.visible = value

func muteWithPause(value):
	mute = value

func _on_ContinueButton_mouse_entered():
	finishedAnimation = true
	if finishedAnimation:
		audio01.play()
		animation1.play("cb")

func _on_RestartButton_mouse_entered():
	finishedAnimation = true
	if finishedAnimation:
		audio01.play()
		animation2.play("rb")

func _on_SaveButton_mouse_entered():
	finishedAnimation = true
	if finishedAnimation:
		audio01.play()
		animation3.play("sb")

func _on_ReturnToLastButton_mouse_entered():
	finishedAnimation = true
	if finishedAnimation:
		audio01.play()
		animation4.play("rtlb")

func _on_SettingsButton_mouse_entered():
	finishedAnimation = true
	if finishedAnimation:
		audio01.play()
		animation5.play("seb")

func _on_MainMenu_mouse_entered():
	finishedAnimation = true
	if finishedAnimation:
		audio01.play()
		animation6.play("mm")

func _on_AnimationPlayer_animation_finished(anim_name):
	finishedAnimation = false

func _on_ContinueButton_mouse_exited():
	animation1.play("cbBack")

func _on_RestartButton_mouse_exited():
	animation2.play("rbBack")

func _on_SaveButton_mouse_exited():
	animation3.play("sbBack")

func _on_ReturnToLastButton_mouse_exited():
	animation4.play("rtlbBack")

func _on_SettingsButton_mouse_exited():
	animation5.play("sebBack")

func _on_MainMenu_mouse_exited():
	animation6.play("mmBack")
