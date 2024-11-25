extends Control

export var background_color: Color = Color(1,1,1)

onready var editor = get_node("/root/EditorState/CamContainer")
onready var playernode = get_node("/root/EditorState/Player")
onready var transitional_cam = playernode.get_node("TransitionalCamera2D")
onready var editor_cam = editor.get_node("Camera2D")


func _ready():
	pass
	
func _draw():
	var cam_size = Vector2(transitional_cam.limit_right - transitional_cam.limit_left, transitional_cam.limit_bottom-transitional_cam.limit_top)
	var cam_rect = Rect2(transitional_cam.position,cam_size)
