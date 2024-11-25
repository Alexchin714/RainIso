extends TextureButton

signal save

var changedKey = false
export var input: String = ""

onready var lab = get_node("Lab")

func _ready():
	#GlobalSettings.connect("keybinds", self, "loadKey")
	set_process_input(false)
	displayKey()

func displayKey():
	lab.text = "%s" % InputMap.get_action_list(input)[0].as_text()
	
func _on_ActionKey_toggled(button_pressed):
	if button_pressed:
		lab.text = "..."
	else:
		displayKey()
	set_process_input(button_pressed)
		
func _input(event):
	remapKey(event)
	pressed = false
	
func remapKey(event):
	SaveSettings.game_data.action_button01 = InputMap.get_action_list(input)[0].as_text()
	InputMap.action_erase_events(input)
	InputMap.action_add_event(input, event)
	lab.text = "%s" % event.as_text()

#func resetKey():
	#if Input.is_action_just_pressed("reset_keybind"):
		#input
