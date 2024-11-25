extends Control

var can_change_key = false
var action_string
enum ACTIONS {w, s, a, d, jump, climb}

func _ready():
	_set_keys()  
  
func _input(event):
	if event is InputEventKey: 
		if can_change_key:
			_change_key(event)
			can_change_key = false
			
func _set_keys():
	for j in ACTIONS:
		get_node("Container/Lab_" + str(j) + "/Button").set_pressed(false)
		if !InputMap.get_action_list(j).empty():
			get_node("Container/Lab_" + str(j) + "/Button").set_text(InputMap.get_action_list(j)[0].as_text())
		else:
			get_node("Container/Lab_" + str(j) + "/Button").set_text("Empty")

func ChangeKey_Up():
	MarkButton("w")

func ChangeKey_Down():
	MarkButton("s")

func ChangeKey_Left():
	MarkButton("a")

func ChangeKey_Right():
	MarkButton("d")

func ChangeKey_Jump():
	MarkButton("jump")
	
func ChangeKey_Climb():
	MarkButton("climb")
	
func MarkButton(string):
	can_change_key = true
	action_string = string
	
	for j in ACTIONS:
		if j != string:
			get_node("Container/Lab_" + str(j) + "/Button").set_pressed(false)

func _change_key(new_key):
	if !InputMap.get_action_list(action_string).empty():
		InputMap.action_erase_event(action_string, InputMap.get_action_list(action_string)[0])
	
	for i in ACTIONS:
		if InputMap.action_has_event(i, new_key):
			InputMap.action_erase_event(i, new_key)
			
	InputMap.action_add_event(action_string, new_key)
	
	_set_keys()
