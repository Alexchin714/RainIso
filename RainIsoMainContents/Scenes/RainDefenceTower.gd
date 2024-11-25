extends Node

func _ready():
	load_main_menu()

func load_main_menu():
	get_node("RDTMainMenu/New").connect("pressed", self, "on_new_game_pressed")
	get_node("RDTMainMenu/Quit").connect("pressed", self, "on_quit_pressed")
	
func on_new_game_pressed():
	get_node("RDTMainMenu").queue_free()
	var game_scene = load("res://Extras/RDTGameScene.tscn").instance()
	game_scene.connect("game_finished", self, 'unload_game')
	add_child(game_scene)

func on_quit_pressed():
	get_tree().change_scene("res://RainIsoMainContents/Scenes/TitleScreen.tscn")

func unload_game(result):
	get_node("RDTGameScene").queue_free()
	var main_menu = load("res://Extras/RDTMainMenu.tscn").instance()
	add_child(main_menu)
	load_main_menu()
