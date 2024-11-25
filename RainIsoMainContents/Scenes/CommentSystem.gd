extends Control

onready var groupLabel = get_node("VBoxContainer/Label")
onready var lineEdit = get_node("VBoxContainer/HBoxContainer/LineEdit")
onready var chatLog = get_node("VBoxContainer/RichTextLabel")
onready var inputLabel = get_node("VBoxContainer/Label")
onready var inputField = get_node("VBoxContainer/HBoxContainer/LineEdit")

var groups = [
	{'name': 'Player', 'color': '#ffffff'},
	{'name': 'Creator', 'color': '#0066ff'},
	{'name': 'Global', 'color': '#ffffff'}
]
	
var group_index = 0
var user_name = 'Player'

func _ready():
	inputField.connect("text_entered", self,'text_entered')
	change_group(0)

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			lineEdit.grab_focus()
			inputField.grab_focus()
		if event.pressed and event.scancode == KEY_ESCAPE:
			lineEdit.release_focus()
			inputField.release_focus()
		if event.pressed and event.scancode == KEY_TAB:
			change_group(1)

func change_group(value):
	group_index += value
	if group_index > (groups.size() - 1):
		group_index = 0
	inputLabel.text = '[' + groups[group_index]['name'] + ']'
	inputLabel.set("custom_colors/font_color", Color(groups[group_index]['color']))

func add_message(username, text, group = 0, color = ''):
	chatLog.bbcode_text += '\n' 
	chatLog.bbcode_text += '[' + username + ']: '
	chatLog.bbcode_text += text
	
func text_entered(text):
	if text =='/h':
		add_message('', 'There is no help message yet!', 0, '#ff5757')
		inputField.text = ''
	if text != '':
		add_message(user_name, text, group_index)
		print(text)
		inputField.text = ''

