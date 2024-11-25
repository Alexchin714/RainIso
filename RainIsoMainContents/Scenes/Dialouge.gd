extends CanvasLayer

signal finished

export(String, "Clement", "The Huntsman", "Claire", "Toby", "Joey", "Beryl", "Prince", "Mr. Popkins", "The Huntsper", "Dr. W LT Talas", "Arnold Buckley") var character
export (String, FILE, "*json") var scene_text_file

var scene_text = {}
var selected_text = []
var in_progress = false

onready var background = $NinePatchRect
onready var name_tag = $NinePatchRect/Name
onready var text_label = $NinePatchRect/Chat

func _ready():
	background.visible = false
	scene_text = load_scene_text()
	SignalBus.connect("displayDialogue", self, "on_display_dialog")

func load_scene_text():
	var file = File.new()
	if file.file_exists(scene_text_file):
		file.open(scene_text_file, File.READ)
		return parse_json(file.get_as_text())

func show_text():
	$AudioStreamPlayer.play()
	name_tag.text = str(character)
	text_label.text = selected_text.pop_front()

func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()

func finish():
	emit_signal("finished")
	text_label.text = ""
	background.visible = false
	in_progress = false
	
func on_display_dialog(text_key):
	if in_progress:
		$AudioStreamPlayer.play()
		next_line()
	else:
		background.visible = true
		in_progress = true
		selected_text = scene_text[text_key].duplicate()
		show_text()
