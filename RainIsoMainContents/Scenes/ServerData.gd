extends Node

var object_data
var test_data = {
		"Stats":{
			"tiles":5,
			"player":1,
			"bought" : [true, false, false],
			"selected": 0,
		}
}

func _ready():
	var level_data_file = File.new()
	level_data_file.open("res//Data/ServerStats.json", File.READ)
	var object_data_json = JSON.parse(level_data_file.get_as_text())
	level_data_file.close()
	object_data = object_data_json.result
