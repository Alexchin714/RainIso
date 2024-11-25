extends Node

var sfx_sound = AudioServer.get_bus_index("SFX")
var music_sound = AudioServer.get_bus_index("Music")
var master_sound = AudioServer.get_bus_index("Master")
var volume_db = -40;
var ao = 0
var enableAdjust
var enSPB = false
var enSPT = false
export(String) var bus_name

signal gdm(value)
signal vignette(value)
signal edge_detection(value)
signal colorblind(value)
signal enableAdjust(value)
signal keybinds(value)
signal speedrun_timer(value)
signal post_processing(value)
signal sensitivity(value)
signal fov(value)
signal sdPauseBg(value)
signal sdPauseText(value)
signal mutewithPause(value)
signal gamma(value)
signal shadows(value)
signal ssao(value)
signal photosensitive_mode(value)
signal screenshake(value)
signal hide_backdrop(value)
signal show_ogf(value)
signal show_vignette(value)
signal fps_displayed(value)
signal show_mod_list(value)
signal dim_mode(value)
signal mono_loading(value)

func toggle_fullscreen(value):
	OS.window_fullscreen = value
	SaveSettings.game_data.fullscreen_on = value
	SaveSettings.save_data()
	
func toggle_vsync(value):
	OS.vsync_enabled = value
	SaveSettings.game_data.vsync_on = value
	SaveSettings.save_data()
	
func toggle_borderless(value):
	OS.window_borderless = value
	SaveSettings.game_data.borderless = value
	SaveSettings.save_data()
	
func toggle_fps_display(value):
	emit_signal("fps_displayed", value)
	SaveSettings.game_data.display_fps = value
	SaveSettings.save_data()
	
func toggle_shadows(value):
	emit_signal("shadows", value)
	SaveSettings.game_data.shadows = value
	SaveSettings.save_data()
	
func toggle_ssao(value):
	emit_signal("ssao", value)
	SaveSettings.game_data.ssao = value
	SaveSettings.save_data()
	
func sensitivity(value):
	emit_signal("sensitivity", value)
	SaveSettings.game_data.sensitivity = value
	SaveSettings.save_data()
	
func fov(value):
	emit_signal("fov", value)
	SaveSettings.game_data.fov = value
	SaveSettings.save_data()
	
func show_pause_bg(value):
	emit_signal("sdPauseBg", value)
	SaveSettings.game_data.show_pause_bg = value
	SaveSettings.save_data()
	
func show_pause_text(value):
	emit_signal("sdPauseText", value)
	SaveSettings.game_data.show_pause_text = value
	SaveSettings.save_data()
	
func toggle_speedrun_timer(value):
	emit_signal("speedrun_timer",value)
	SaveSettings.game_data.speedrun_timer = value
	SaveSettings.save_data()
	
func mod_list_show(value):
	emit_signal("show_mod_list", value)
	SaveSettings.game_data.show_mod_list = value
	SaveSettings.save_data()
	
func gamma(value):
	emit_signal("gamma", value)
	SaveSettings.game_data.gamma = value
	SaveSettings.save_data()
	
func enableAdjustments(value):
	emit_signal("enableAdjust", value)
	SaveSettings.game_data.enableAdjustment = value
	SaveSettings.save_data()
	
func update_master_vol(vol):
	AudioServer.set_bus_volume_db(0, vol)
	SaveSettings.game_data.master_vol = vol
	SaveSettings.save_data()
	
func update_music_vol(vol):
	AudioServer.set_bus_volume_db(1, vol)
	SaveSettings.game_data.music_vol = vol
	SaveSettings.save_data()
	
func update_sfx_vol(vol):
	AudioServer.set_bus_volume_db(2, vol)
	SaveSettings.game_data.sfx_vol = vol
	SaveSettings.save_data()
	
func muteMusic(vol):
	AudioServer.set_bus_volume_db(music_sound, not AudioServer.is_bus_mute(music_sound))
	SaveSettings.game_data.sfx_vol = vol
	SaveSettings.save_data()
	
func assistmode_on_default(value):
	pass
	SaveSettings.game_data.assistmode_by_default = value
	SaveSettings.save_data()
	
func photosensitive_mode(value):
	pass
	SaveSettings.game_data.photosensitive_mode = value
	SaveSettings.save_data()
	
func screenshake(value):
	pass
	SaveSettings.game_data.screenshake = value
	SaveSettings.save_data()
	
func set_language(value):
	pass
	SaveSettings.game_data.language = value
	SaveSettings.save_data()
	
func set_max_fps(value):
	Engine.target_fps = value if value < 500 else 0 
	SaveSettings.game_data.max_fps = Engine.target_fps if value < 500 else 500
	SaveSettings.save_data()
		
func post_processing(value):
	emit_signal("post_processing", value)
	SaveSettings.game_data.post_processing = value
	SaveSettings.save_data()

func dim_mode(value):
	emit_signal("dim_mode", value)
	SaveSettings.game_data.dim_mode = value
	SaveSettings.save_data()
	
func mono_loading(value):
	emit_signal("mono_loading", value)
	SaveSettings.game_data.monochromatic_loading = value
	SaveSettings.save_data()
	
func colorblind(value):
	emit_signal("colorblind", value)
	SaveSettings.game_data.colorblind = value
	SaveSettings.save_data()
	
func action_button(value):
	emit_signal("keybinds", value)
	SaveSettings.game_data.action_button01 = value
	SaveSettings.game_data.action_button02 = value
	SaveSettings.game_data.action_button03 = value
	SaveSettings.game_data.action_button04 = value
	SaveSettings.game_data.action_button05 = value
	SaveSettings.game_data.action_button06 = value
	SaveSettings.game_data.action_button07 = value
	SaveSettings.game_data.action_button08 = value
	SaveSettings.game_data.action_button09 = value
	
	SaveSettings.save_data()

func save_key(value, text):
	SaveSettings.game_data.keys = text
	SaveSettings.save_data()

func gdm(value):
	emit_signal("gdm", value)
	SaveSettings.game_data.firstFilter = value
	SaveSettings.save_data()

func vignette(value):
	emit_signal("vignette", value)
	SaveSettings.game_data.secondFilter = value
	SaveSettings.save_data()
	
func edge_detection(value):
	emit_signal("edge_detection", value)
	SaveSettings.game_data.edge_detection = value
	SaveSettings.save_data()

func show_backdrop(value):
	emit_signal("hide_backdrop",value)
	SaveSettings.game_data.show_backdrop = value
	SaveSettings.save_data()

func disable_screenshake(value):
	emit_signal("screenshake", value)
	SaveSettings.game_data.screenshake = value
	SaveSettings.save_data()

func show_ogf(value):
	emit_signal("show_ogf", value)
	SaveSettings.game_data.show_old_grain_filter = value
	SaveSettings.save_data()
	
func show_vignette(value):
	emit_signal("show_vignette", value)
	SaveSettings.game_data.show_vignette = value
	SaveSettings.save_data()

func mutewpause(value):
	emit_signal("mutewithPause", value)
	SaveSettings.game_data.mutewpause = value
	SaveSettings.save_data()
