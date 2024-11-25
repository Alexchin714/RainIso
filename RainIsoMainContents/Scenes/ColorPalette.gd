extends CanvasLayer

onready var http : HTTPRequest = $HTTPRequest
onready var level = $Control/LineEdit
onready var contents = $Control/Princely
onready var notification = $Control/Label
onready var character = $Control/Character
onready var ani = get_owner().get_node("ItemSelectionScreen/Panel/Main/HalfCircle02/AnimationPlayer")
onready var object_cursor = get_node("/root/EditorState/Editor_Objects")
var ColorModulate = load("res://RainIsoMainContents/Scenes/Editor.tscn")
var trr = false

var new_profile = false
var information_sent = false
var profile = {
	"Level": {},
	"Contents": {},
	"Character": {}    
}
func _ready():
	set_visible(false)
	#Firebase.get_document("users/%s" % Firebase.level_info.id, http)
	
func _process(delta):
	if Input.is_action_just_pressed("esc") and trr:
		trr = false
		$Control/AnimationPlayer.play_backwards("transition")

func _on_Continue_pressed():
		get_tree().paused = false
		set_visible(false)

func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible


func _on_Control_mouse_entered():
	object_cursor.can_place = false
	object_cursor.hide()
	pass # Replace with function body.

func _on_Control_mouse_exited():
	object_cursor.can_place = true
	object_cursor.show()
	pass # Replace with function body.



func _on_Filter_pressed():
	$CanvasLayer4/Sprite/GlowPiece.visible = false


func _on_Button_pressed():
	get_node("Level/TileMap").set_modulate(Color(255,0,0))


func _on_BG1_pressed():
	$Outline.visible = false
	$White.visible = false


func _on_BG1_button_up():
	$Outline.visible = true
	$White.visible = true

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		404:
			notification.text = "Please, enter your information"
			new_profile = true
			return
		200:
			if information_sent:
				notification.text = "Information saved successfully"
				information_sent = false
			self.profile = result_body.fields

func set_profile(value: Dictionary) -> void:
	profile = value
	level.text = profile.level.stringValue
	contents.text = profile.contents.stringValue
	character.value = int(profile.character.integerValue)

func _on_BackButton_pressed():
	if trr == true:
		trr = false
		$Control/AnimationPlayer.play_backwards("transition")

func _on_Space_pressed():
	trr = true
