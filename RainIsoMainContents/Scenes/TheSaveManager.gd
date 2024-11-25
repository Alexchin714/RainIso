extends Node

#Default values
var level = 1
var player_position = 4
var player_speed = 2
var level_objects = 3
var checkpoint = 0

var game_data : Dictionary

onready var lbldata : Label = $lblgamedata

func _ready():
	#update with default values, this will change when you save
	update_data()
	pass

func update_data():

	game_data = {"player_data" : 
		{
			"pos" : player_position,
			"speed" : player_speed,
			"objectcount" : level_objects
		},

		"level_data" : 
		{
			"level" : level,
			"checkpoint" : checkpoint
		}
	}

func do_save():
	var file : File = File.new()
	file.open("res://saved_game/game.dat",File.WRITE)
	file.store_line(to_json(game_data))
	file.close()

func do_load():
	var file : File = File.new()

	file.open("res://saved_game/game.dat",File.READ)

	game_data = parse_json(file.get_as_text())

	file.close()

func _physics_process(delta):

	if(Input.is_action_just_pressed("save_key")):
		#DOSAVE
		if(get_tree().current_scene.name.begins_with("level")):
			print("can_save")
			do_save()
		else:
			print("cannot save")
		pass

	if(Input.is_action_just_pressed("print_key")):
		print("level : " + str(level))
		print("pos : " + str(player_position))
		print("theobjectcountsuccessfully : " + str(level_objects))
		print("player speed : " + str(player_speed))
		print(" ----------------- ")

func show_data():
	lbldata.text = "level : " + str(level) + "\n \n"
	lbldata.text += "pos : " + str(player_position) + "\n \n"
	lbldata.text += "speed : " + str(player_speed) + "\n \n"
	lbldata.text += "objs : " + str(level_objects)
	lbldata.show()

func hide_data():
	lbldata.hide()
