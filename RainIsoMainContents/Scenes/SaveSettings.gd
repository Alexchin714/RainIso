extends Node

const SAVEFILE = "user://rainsettings.frgo"

var game_data = {}

func _ready():
	load_data()
	
func load_data():
	var file = File.new()
	if not file.file_exists(SAVEFILE):
		game_data = {
			"fullscreen_on": false,
			"vsync_on": false,
			"borderless" : false,
			"display_fps" : false,
			"sensitivity" : 90,
			"maxfps" : 0,
			"fov" : 70,
			"gamma" : 1,
			"show_pause_bg" : true,
			"show_pause_text" : true,
			"speedrun_timer" : false,
			"show_mod_list" : false,
			"colorblind" : 0,
			"master_vol" : -4,
			"max_fps" : 0,
			"music_vol" : -4,
			"sfx_vol" : -4,
			"mutewpause" : false,
			"enableAdjustment" : true,
			"gdm" : false,
			"vignette" : true,
			"edge_detection" : true,
			"assistmode_by_default" : false,
			"photosensitive_mode" : false,
			"screenshake" : false,
			"language" : false,
			"post_processing" : true,
			"shadows" : true,
			"ssao" : true,
			"enviromentallighting" : true,
			"show_backdrop" : true,
			"show_old_grain_filter" : true,
			"dim_mode" : false,
			"monochromatic_loading": false,
			"keys": false,
			"action_button01" : false,
			"action_button02" : false,
			"action_button03" : false,
			"action_button04" : false,
			"action_button05" : false,
			"action_button06" : false,
			"action_button07" : false,
			"action_button08" : false,
			"action_button09" : false,
			"action_button10" : false,
			"action_button11" : false,
			"action_button12" : false,
			"action_button13" : false,
			"action_button14" : false,
			"action_button15" : false,
			"action_button16" : false,
		}
		save_data()
	file.open(SAVEFILE, File.READ)
	game_data = file.get_var()
	file.close()
	
func save_data():
	var file = File.new()
	file.open(SAVEFILE, File.WRITE)
	file.store_var(game_data)
	file.close()
