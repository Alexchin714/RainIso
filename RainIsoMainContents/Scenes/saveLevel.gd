extends Node

const SAVEFILE = "user://rainlevels.frgo"

var game_data = {}

func _ready():
	load_data()
	
func load_data():
	var file = File.new()
	if not file.file_exists(SAVEFILE):
		game_data = {
			"melodyBackground": false,
			"journeystep": false,
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
