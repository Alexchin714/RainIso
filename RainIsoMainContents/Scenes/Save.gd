extends Node

const SAVEFILE = "user://keysaveFile.amph"
var data = {}

func _ready():
	loadData()
	
func saveData():
	var file = File.new()
	file.open(SAVEFILE, file.WRITE)
	file.store_var(data)
	file.close()
	
func loadData():
	var file = File.new()
	if not file.file_exists(SAVEFILE):
		data = {
			"actionbutton01": 0,
			"actionbutton02": 0,
			"actionbutton03": 0,
			"actionbutton04": 0,
			"actionbutton05": 0,
			"actionbutton06": 0,
			"actionbutton07": 0,
			"actionbutton08": 0,
		}
		saveData()
	file.open(SAVEFILE, File.READ)
	data = file.get_var()
	file.close()
