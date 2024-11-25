extends CanvasLayer

var pg = false
var gpg = false
var step := 0
var page := 0
var backVerify := false
var back := false
var backSecondary := false
var isInSettings := false
#Audio Buses
var Master := AudioServer.get_bus_index("Master")
var Musica := AudioServer.get_bus_index("Music")
var SFX := AudioServer.get_bus_index("SFX")
#Main
onready var displayNode := get_node("Node/Display")
onready var audioNode := get_node("Node/Audio")
onready var graphicNode := get_node("Node/Graphic")
onready var languageNode := get_node("Node/Language")
onready var controlNode := get_node("Node/Controls")
#TopSide
onready var display := get_node("Node/HighlightButtons/Display")
onready var audio := get_node("Node/HighlightButtons/Audio")
onready var graphics := get_node("Node/HighlightButtons/Graphics")
onready var languages := get_node("Node/HighlightButtons/Language")
onready var controls := get_node("Node/HighlightButtons/Controls")
#Video
onready var window := get_node("Node/Display/DisplayPage01/Window")
onready var vsync := get_node("Node/Display/DisplayPage01/VSync")
onready var borderless := get_node("Node/Display/DisplayPage01/Borderless")
onready var displayfps := get_node("Node/Display/DisplayPage01/DisplayFps")
onready var dimMode := get_node("Node/Display/DisplayPage02/DimMode")
onready var photosensitiveMode := get_node("Node/Display/DisplayPage01/PhotosensitiveMode")
onready var sensitivity := get_node("Node/Display/DisplayPage01/Sensitivity")
onready var maxfps := get_node("Node/Display/DisplayPage01/MaxFps")
onready var fov := get_node("Node/Display/DisplayPage01/FOV")
onready var sds := get_node("Node/Display/DisplayPage02/ShowPauseScreen")
onready var spt := get_node("Node/Display/DisplayPage02/ShowPauseText")
onready var monochromatic := get_node("Node/Display/DisplayPage02/MonochromaticLoadingScreen")
#Audio
onready var musicSlider := get_node("Node/Audio/Music")
onready var sfxSlider := get_node("Node/Audio/SFX")
onready var masterSlider := get_node("Node/Audio/Master")
#Graphics
onready var postProcess := get_node("Node/Graphic/GraphicPage01/PostProcess")
onready var shadows := get_node("Node/Graphic/GraphicPage01/Shadows")
onready var gdm := get_node("Node/Graphic/GraphicPage01/GDM")
onready var vignette := get_node("Node/Graphic/GraphicPage01/Vignette")
onready var ssao := get_node("Node/Graphic/GraphicPage01/SSAO")
onready var adjust := get_node("Node/Graphic/GraphicPage02/Adjustments")
onready var gamma := get_node("Node/Graphic/GraphicPage02/Gamma")
onready var colorblinds := get_node("Node/Graphic/GraphicPage01/Colorblind")
onready var showBackdrop := get_node("Node/Graphic/GraphicPage02/ShowBackdrop")
onready var sgf := get_node("Node/Graphic/GraphicPage02/ShowGrainFilter")
onready var disableScreenShake := get_node("Node/Graphic/GraphicPage02/DisableScreenshake")
onready var edgeDetection := get_node("Node/Graphic/GraphicPage01/EdgeDetection")
#Language
onready var language := get_node("Node/Language/Languages")
#Control
onready var actionButton01 := get_node("Node/Controls/ScrollContainer/Control/ActionButton")
onready var actionButton02 := get_node("Node/Controls/ScrollContainer/Control/ActionButton2")
onready var actionButton03 := get_node("Node/Controls/ScrollContainer/Control/ActionButton3")
onready var actionButton04 := get_node("Node/Controls/ScrollContainer/Control/ActionButton4")
onready var actionButton05 := get_node("Node/Controls/ScrollContainer/Control/ActionButton5")
onready var actionButton06 := get_node("Node/Controls/ScrollContainer/Control/ActionButton6")
onready var actionButton07 := get_node("Node/Controls/ScrollContainer/Control/ActionButton7")
onready var actionButton08 := get_node("Node/Controls/ScrollContainer/Control/ActionButton8")
onready var actionButton09 := get_node("Node/Controls/ScrollContainer/Control/ActionButton9")
onready var actionButton10 := get_node("Node/Controls/ScrollContainer/Control/ActionButton10")
onready var actionButton11 := get_node("Node/Controls/ScrollContainer/Control/ActionButton11")
#Highlighter
onready var openPlayer := get_node("OpenPlayer")
onready var highlightButtons := get_node("Node/HighlightButtons")
onready var adjustPlayer := get_node("Node/Display/DisplayPage01/AdjustPlayer")
#OGG
onready var firstSound := get_node("Audio/Sound")
onready var secondSound := get_node("Audio/HigherSound")
onready var secondarySound := get_node("Audio/SecondSound")
onready var thirdSound_ := get_node("Audio/FourthSound")
#Page
onready var page01 := get_node("Node/Display/DisplayPage01")
onready var page02 := get_node("Node/Display/DisplayPage02")
onready var graphicpage01 := get_node("Node/Graphic/GraphicPage01")
onready var graphicpage02 := get_node("Node/Graphic/GraphicPage02")
#Positions
onready var transition := get_node("Transition/TransitionAssets/Transition")
onready var pos01 := get_node("Positions/Pos01")
onready var pos02 := get_node("Positions/Pos02")
onready var pos03 := get_node("Positions/Pos03")
onready var pos04 := get_node("Positions/Pos04")
onready var pos05 := get_node("Positions/Pos05")
#Select Positions
onready var selectPos01 := get_node("Positions/Select/Pos01")
onready var selectPos02 := get_node("Positions/Select/Pos02")
onready var selectPos03 := get_node("Positions/Select/Pos03")
onready var selectPos04 := get_node("Positions/Select/Pos04")
onready var selectPos05 := get_node("Positions/Select/Pos05")
onready var selectPos06 := get_node("Positions/Select/Pos06")
onready var selectPos07 := get_node("Positions/Select/Pos07")
onready var selectPos08 := get_node("Positions/Select/Pos08")
onready var selectPos09 := get_node("Positions/Select/Pos09")
onready var selectPos10 := get_node("Positions/Select/Pos10")
onready var selectPos11 := get_node("Positions/Select/Pos12")
#PosTweens
onready var tween := get_node("Positions/Tween")

func _ready():
	var modsFile = File.new()
	var doFileExists = modsFile.file_exists("res://Mods/")
	#Video
	window.select(1 if SaveSettings.game_data.fullscreen_on else 0)
	GlobalSettings.toggle_fullscreen(SaveSettings.game_data.fullscreen_on)
	vsync.pressed = SaveSettings.game_data.vsync_on
	borderless.pressed = SaveSettings.game_data.borderless
	displayfps.pressed = SaveSettings.game_data.display_fps
	photosensitiveMode.pressed = SaveSettings.game_data.photosensitive_mode
	maxfps.value = SaveSettings.game_data.max_fps
	sensitivity.value = SaveSettings.game_data.sensitivity
	fov.value = SaveSettings.game_data.fov
	dimMode.pressed = SaveSettings.game_data.dim_mode
	sds.pressed = SaveSettings.game_data.show_pause_bg
	spt.pressed = SaveSettings.game_data.show_pause_text
	#monochromatic.pressed = SaveSettings.game_data.monochromatic_loading
	#speedruntimer.pressed = SaveSettings.game_data.speedrun_timer
	#Audio
	masterSlider.value = SaveSettings.game_data.master_vol
	musicSlider.value = SaveSettings.game_data.music_vol
	sfxSlider.value = SaveSettings.game_data.sfx_vol
	#Graphics
	postProcess.pressed = SaveSettings.game_data.post_processing
	shadows.pressed = SaveSettings.game_data.shadows
	gdm.pressed = SaveSettings.game_data.gdm
	vignette.pressed = SaveSettings.game_data.vignette
	ssao.pressed = SaveSettings.game_data.ssao
	adjust.pressed = SaveSettings.game_data.enableAdjustment
	gamma.value = SaveSettings.game_data.gamma
	colorblinds.value = SaveSettings.game_data.colorblind
	showBackdrop.pressed = SaveSettings.game_data.show_backdrop
	sgf.pressed = SaveSettings.game_data.show_old_grain_filter
	edgeDetection.pressed = SaveSettings.game_data.edge_detection
	#Control
	actionButton01.pressed = SaveSettings.game_data.action_button01
	actionButton02.pressed = SaveSettings.game_data.action_button02
	actionButton03.pressed = SaveSettings.game_data.action_button03
	actionButton04.pressed = SaveSettings.game_data.action_button04
	actionButton05.pressed = SaveSettings.game_data.action_button05
	actionButton06.pressed = SaveSettings.game_data.action_button06
	actionButton07.pressed = SaveSettings.game_data.action_button07
	actionButton08.pressed = SaveSettings.game_data.action_button08
	actionButton09.pressed = SaveSettings.game_data.action_button09
	actionButton10.pressed = SaveSettings.game_data.action_button10
	actionButton11.pressed = SaveSettings.game_data.action_button11
	#Mods
	
func _process(delta):
	stepSystem()
	verifyBack()
	goBack()
	
func _on_Window_item_selected(index: int):
	#sound()
	GlobalSettings.toggle_fullscreen(index)

func _on_VSync_toggled(button_pressed):
	#sound()
	GlobalSettings.toggle_vsync(button_pressed)

func _on_DisplayFps_toggled(button_pressed):
	#sound()
	GlobalSettings.toggle_fps_display(button_pressed)

func _on_Sensitivity_value_changed(value):
	#sound()
	GlobalSettings.sensitivity(value)

func _on_MaxFps_value_changed(value):
	#sound()
	GlobalSettings.set_max_fps(value)

func _on_FOV_value_changed(value):
	#sound()
	GlobalSettings.fov(value)

func _on_Music_value_changed(value):
	#sound()
	GlobalSettings.update_music_vol(value)
	if value < -9:
		AudioServer.set_bus_mute(Musica, true)
	else:
		AudioServer.set_bus_mute(Musica, false)
		
func _on_SFX_value_changed(value):
	#sound()
	GlobalSettings.update_sfx_vol(value)
	if value < -9:
		AudioServer.set_bus_mute(SFX, true)
	else:
		AudioServer.set_bus_mute(SFX, false)

func _on_Master_value_changed(value):
	#sound()
	GlobalSettings.update_master_vol(value)
	if value < -9:
		AudioServer.set_bus_mute(Master, true)
	else:
		AudioServer.set_bus_mute(Master, false)
		
func _on_PostProcess_toggled(button_pressed):
	#sound()
	GlobalSettings.post_processing(button_pressed)

func _on_Shadows_toggled(button_pressed):
	#sound()
	GlobalSettings.toggle_shadows(button_pressed)

func _on_SSAO_toggled(button_pressed):
	#sound()
	GlobalSettings.toggle_ssao(button_pressed)

func _on_Gamma_value_changed(value):
	#sound()
	GlobalSettings.gamma(value)

func _on_Language_item_selected(index):
	#sound()
	GlobalSettings.set_language(index)

func _on_Display_pressed():
	$Node/HighlightButtons.visible = false
	$Node/HighlightButtons/HighlightPlayer.play("RESET")
	sound()
	page = 1
	back = false
	backSecondary = true
	pageSelector()
	
func _on_Audio_pressed():
	$Node/HighlightButtons.visible = false
	$Node/HighlightButtons/HighlightPlayer.play("RESET")
	sound()
	page = 2
	back = false
	backSecondary = true
	pageSelector()

func _on_Graphics_pressed():
	$Node/HighlightButtons.visible = false
	$Node/HighlightButtons/HighlightPlayer.play("RESET")
	sound()
	page = 3
	back = false
	backSecondary = true
	pageSelector()

func _on_Language_pressed():
	$Node/HighlightButtons.visible = false
	$Node/HighlightButtons/HighlightPlayer.play("RESET")
	sound()
	page = 4
	back = false
	backSecondary = true
	pageSelector()

func _on_Controls_pressed():
	$Node/HighlightButtons.visible = false
	$Node/HighlightButtons/HighlightPlayer.play("RESET")
	sound()
	page = 5
	back = false
	backSecondary = true
	pageSelector()

func pageSelector():
	displayNode.visible = page == 1
	audioNode.visible = page == 2
	graphicNode.visible = page == 3
	languageNode.visible = page == 4
	controlNode.visible = page == 5

func stepSystem():
	if Input.is_action_pressed("sneak"):
		maxfps.step = 10
		sensitivity.step = 0.05
		fov.step = 10
		masterSlider.step = 2
		musicSlider.step = 2
		sfxSlider.step = 2
		gamma.step = .2
		colorblinds.step = 2
		if Input.is_action_pressed("sprint"):
			maxfps.step = 100
			sensitivity.step = 0.25
			fov.step = 50
			masterSlider.step = 10
			musicSlider.step = 10
			sfxSlider.step = 10
			gamma.step = 1
			colorblinds.step = 4
	else:
		maxfps.step = 1
		sensitivity.step = 0.01
		fov.step = 1
		masterSlider.step = 1
		musicSlider.step = 1
		sfxSlider.step = 1
		gamma.step = .1
		colorblinds.step = 1

func verifyBack():
	if Input.is_action_just_pressed("ui_cancel") && backVerify:
		$TransitionPlayer.play("RESET")
		backVerify = false
		back()

func _on_DimMode_toggled(button_pressed):
	#sound()
	GlobalSettings.dim_mode(button_pressed)

func _on_PhotosensitiveMode_toggled(button_pressed):
	#sound()
	GlobalSettings.photosensitive_mode(button_pressed)

func openSettings():
	openPlayer.play("open")
	back = true
	
func back():
	openPlayer.play_backwards("open")

func _on_Adjustments_toggled(button_pressed):
	#sound()
	GlobalSettings.enableAdjustments(button_pressed)

func _on_Colorblind_value_changed(value):
	#sound()
	GlobalSettings.colorblind(value)

func _on_GDM_toggled(button_pressed):
	#sound()
	GlobalSettings.gdm(button_pressed)

func _on_Vignette_toggled(button_pressed):
	#sound()
	GlobalSettings.vignette(button_pressed)

func _on_EdgeDetection_toggled(button_pressed):
	#sound()
	GlobalSettings.edge_detection(button_pressed)

func _on_Back_pressed():
	$TransitionPlayer.play("RESET")
	secondSound()
	backSecondary = false
	back = true
	displayNode.visible = false
	audioNode.visible = false
	graphicNode.visible = false
	languageNode.visible = false
	controlNode.visible = false
	highlightButtons.visible = true

func goBack():
	if Input.is_action_just_pressed("esc"):
		if back == true:
			isInSettings = false
			$TransitionPlayer.play("RESET")
			secondSound()
			back = false
			$OpenPlayer.play_backwards("open")
		if backSecondary == true:
			$Node/HighlightButtons/HighlightPlayer.play("RESET")
			$TransitionPlayer.play("RESET")
			secondSound()
			backSecondary = false
			back = true
			displayNode.visible = false
			audioNode.visible = false
			graphicNode.visible = false
			languageNode.visible = false
			controlNode.visible = false
			highlightButtons.visible = true

func _on_Languages_pressed():
	$Node/Language/Label/AnimationPlayer.play("sry")

func pg01():
	higherSound()
	page01.visible = true
	page02.visible = false

func pg02():
	higherSound()
	page01.visible = false
	page02.visible = true

func _on_ShowPauseScreen_toggled(button_pressed):
	#sound()
	GlobalSettings.show_pause_bg(button_pressed)

func _on_ShowPauseText_toggled(button_pressed):
	#sound()
	GlobalSettings.show_pause_text(button_pressed)

func _on_ShowBackdrop_toggled(button_pressed):
	#sound()
	GlobalSettings.show_backdrop(button_pressed)

func Gpg01():
	#higherSound()
	graphicpage01.visible = true
	graphicpage02.visible = false

func Gpg02():
	#higherSound()
	graphicpage01.visible = false
	graphicpage02.visible = true

func _on_DisableScreenshake_toggled(button_pressed):
	#sound()
	GlobalSettings.disable_screenshake(button_pressed)

func _on_ShowGrainFilter_toggled(button_pressed):
	#sound()
	GlobalSettings.show_ogf(button_pressed)

func _on_ShowVignette_toggled(button_pressed):
	#sound()
	GlobalSettings.show_vignette(button_pressed)

func _on_Borderless_toggled(button_pressed):
	#sound()
	GlobalSettings.toggle_borderless(button_pressed)

func _on_MuteMusic_toggled(button_pressed):
	#sound()
	GlobalSettings.mutewpause(button_pressed)

func _on_Display_mouse_entered():
	$Node/HighlightButtons/HoverPlayer01.play("highlight")
	$Audio/ThirdSound.play()

func _on_Audio_mouse_entered():
	$Node/HighlightButtons/HoverPlayer02.play("highlight")
	$Audio/ThirdSound.play()

func _on_Graphics_mouse_entered():
	$Node/HighlightButtons/HoverPlayer03.play("highlight")
	$Audio/ThirdSound.play()

func _on_Language_mouse_entered():
	$Node/HighlightButtons/HoverPlayer04.play("highlight")
	$Audio/ThirdSound.play()

func _on_Controls_mouse_entered():
	$Node/HighlightButtons/HoverPlayer05.play("highlight")
	$Audio/ThirdSound.play()

func _on_Display_mouse_exited():
	$Node/HighlightButtons/HoverPlayer01.play_backwards("highlight")

func _on_Audio_mouse_exited():
	$Node/HighlightButtons/HoverPlayer02.play_backwards("highlight")

func _on_Graphics_mouse_exited():
	$Node/HighlightButtons/HoverPlayer03.play_backwards("highlight")

func _on_Language_mouse_exited():
	$Node/HighlightButtons/HoverPlayer04.play_backwards("highlight")

func _on_Controls_mouse_exited():
	$Node/HighlightButtons/HoverPlayer05.play_backwards("highlight")

func _on_Back_mouse_entered():
	$Node/Back/AnimationPlayer.play("back")

func _on_Back_mouse_exited():
	$Node/Back/AnimationPlayer.play("backBack")

func moveTDis():
	tween.interpolate_property($Transition/TransitionAssets/Transition, "position",
		transition.position, pos01.position, .65,
		Tween.TRANS_CIRC, Tween.EASE_OUT)
	tween.start()

func moveTAudi():
	tween.interpolate_property($Transition/TransitionAssets/Transition, "position",
		transition.position, pos02.position, .65,
		Tween.TRANS_CIRC, Tween.EASE_OUT)
	tween.start()
	
func moveTGraph():
	tween.interpolate_property($Transition/TransitionAssets/Transition, "position",
		transition.position, pos03.position, .65,
		Tween.TRANS_CIRC, Tween.EASE_OUT)
	tween.start()
	
func moveTlang():
	tween.interpolate_property($Transition/TransitionAssets/Transition, "position",
		transition.position, pos04.position, .65,
		Tween.TRANS_CIRC, Tween.EASE_OUT)
	tween.start()
	
func moveTCont():
	tween.interpolate_property($Transition/TransitionAssets/Transition, "position",
		transition.position, pos05.position, .65,
		Tween.TRANS_CIRC, Tween.EASE_OUT)
	tween.start()

func _on_VSync_mouse_entered():
	thirdSound()
	$Node/Display/VSync.play("select")

func _on_VSync_mouse_exited():
	$Node/Display/VSync.play_backwards("select")

func _on_DisplayFps_mouse_entered():
	thirdSound()
	$Node/Display/DisplayFPS.play("select")

func _on_DisplayFps_mouse_exited():
	$Node/Display/DisplayFPS.play_backwards("select")

func _on_Borderless_mouse_entered():
	thirdSound()
	$Node/Display/Borderless.play("select")

func _on_Borderless_mouse_exited():
	$Node/Display/Borderless.play_backwards("select")

func _on_PhotosensitiveMode_mouse_entered():
	thirdSound()
	$Node/Display/PhotosensitiveMode.play("select")

func _on_PhotosensitiveMode_mouse_exited():
	$Node/Display/PhotosensitiveMode.play_backwards("select")

func _on_DimMode_mouse_entered():
	thirdSound()
	$Node/Display/DimMode.play("select")

func _on_DimMode_mouse_exited():
	$Node/Display/DimMode.play_backwards("select")

func _on_ShowPauseScreen_mouse_entered():
	thirdSound()
	$Node/Display/SPS.play("select")

func _on_ShowPauseScreen_mouse_exited():
	$Node/Display/SPS.play_backwards("select")

func _on_ShowPauseText_mouse_entered():
	thirdSound()
	$Node/Display/SPT.play("select")

func _on_ShowPauseText_mouse_exited():
	$Node/Display/SPT.play_backwards("select")

func _on_MuteMusic_mouse_entered():
	thirdSound()
	$Node/Audio/MMWP.play("select")

func _on_MuteMusic_mouse_exited():
	$Node/Audio/MMWP.play_backwards("select")

func _on_PostProcess_mouse_entered():
	thirdSound()
	$Node/Graphic/PostProcessing.play("select")

func _on_PostProcess_mouse_exited():
	$Node/Graphic/PostProcessing.play_backwards("select")

func _on_Shadows_mouse_entered():
	thirdSound()
	$Node/Graphic/Shadows.play("select")

func _on_Shadows_mouse_exited():
	$Node/Graphic/Shadows.play_backwards("select")

func _on_FirstFilter_mouse_entered():
	thirdSound()
	$Node/Graphic/FirstFilter.play("select")

func _on_FirstFilter_mouse_exited():
	$Node/Graphic/FirstFilter.play_backwards("select")

func _on_SecondFilter_mouse_entered():
	thirdSound()
	$Node/Graphic/SecondFilter.play("select")

func _on_SecondFilter_mouse_exited():
	$Node/Graphic/SecondFilter.play_backwards("select")

func _on_EdgeDetection_mouse_entered():
	thirdSound()
	$Node/Graphic/EdgeDetection.play("select")

func _on_EdgeDetection_mouse_exited():
	$Node/Graphic/EdgeDetection.play_backwards("select")

func _on_SSAO_mouse_entered():
	thirdSound()
	$Node/Graphic/SSAO.play("select")

func _on_SSAO_mouse_exited():
	$Node/Graphic/SSAO.play_backwards("select")

func _on_Adjustments_mouse_entered():
	thirdSound()
	$Node/Graphic/EnableAdjustments.play("select")

func _on_Adjustments_mouse_exited():
	$Node/Graphic/EnableAdjustments.play_backwards("select")

func _on_ShowBackdrop_mouse_entered():
	thirdSound()
	$Node/Graphic/ShowBackdrop.play("select")

func _on_ShowBackdrop_mouse_exited():
	$Node/Graphic/ShowBackdrop.play_backwards("select")

func _on_DisableScreenshake_mouse_entered():
	thirdSound()
	$Node/Graphic/DisableShake.play("select")

func _on_DisableScreenshake_mouse_exited():
	$Node/Graphic/DisableShake.play_backwards("select")

func _on_ShowGrainFilter_mouse_entered():
	thirdSound()
	$Node/Graphic/ShowGrainFilter.play("select")

func _on_ShowGrainFilter_mouse_exited():
	$Node/Graphic/ShowGrainFilter.play_backwards("select")

func _on_ShowVignette_mouse_entered():
	thirdSound()
	$Node/Graphic/ShowVignette.play("select")

func _on_ShowVignette_mouse_exited():
	$Node/Graphic/ShowVignette.play_backwards("select")

func _on_Languages_mouse_entered():
	thirdSound()
	$Node/Language/Language.play("select")

func _on_Languages_mouse_exited():
	$Node/Language/Language.play_backwards("select")

func sound():
	firstSound.play()
	
func higherSound():
	secondSound.play()
	
func secondSound():
	secondarySound.play()
	
func thirdSound():
	thirdSound_.play()

func _on_MonochromaticLoadingScreen_toggled(button_pressed):
	GlobalSettings.mono_loading(button_pressed)

func _on_MonochromaticLoadingScreen_mouse_entered():
	thirdSound()
	$Node/Display/Mono.play("select")

func _on_MonochromaticLoadingScreen_mouse_exited():
	$Node/Display/Mono.play_backwards("select")

func _on_PageButton_pressed():
	pg = !pg
	if pg:
		pg02()
	else:
		pg01()

func _on_PageButtonG_pressed():
	gpg = !gpg
	if gpg:
		Gpg02()
	else:
		Gpg01()
