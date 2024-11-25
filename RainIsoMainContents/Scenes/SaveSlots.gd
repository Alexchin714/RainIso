extends Node2D

const baseFilePath = "res://SaveFiles"
var fileName = "res://SaveFiles/save.json"

var data={}

func saveData(variableName, value):
	data[variableName] = value
	var file = File.new()
	file.open(fileName, File.WRITE)
	file.store_string(to_json(data))
	file.close()
	
func loadData():
	var file = File.new()
	if file.file_exists(fileName):
		file.open(fileName, File.READ)
		var saveData = parse_json(file.get_as_text())
		file.close()
		
		if typeof(saveData) == TYPE_DICTIONARY:
			data = saveData

func setSaveSlot(slot):
	data = {}
	fileName = baseFilePath + slot
	
func _ready():
	setSaveSlot('save1')
	loadData()
	saveData("Level", 3)


func _on_Button_pressed():
	$AnimationPlayer.play("SaveSlots")
	$Timer.start()
	
func _on_Timer_timeout():
	get_tree().change_scene("res://LevelSelectionScreen.tscn")
