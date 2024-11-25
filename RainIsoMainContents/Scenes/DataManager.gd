extends Node

const fileName = "rainiso.frgo"
var data = {}

func _ready():
	loadData()
	
func loadData():
	var file = File.new()
	if file.file_exists("user://"+fileName):
		file.open("user://"+fileName, file.READ)
		data = file.get_var()
		file.close()
	else:
		data = {
			"Positions": {},
			"CM": {},
		}
	
func saveData():
	var file = File.new()
	file.open("user://"+fileName, file.WRITE)
	file.store_var(data)
	file.close()
