extends Sprite

func _ready():
	pass # Replace with function body.

func _process(delta):
	if (!Global.filesystem_shown):
		if Input.is_action_just_pressed("toggle_editor"):
			Global.playing = !Global.playing
			visible = !Global.playing
	pass
	

func _on_BGCOLOR_color_changed(color : Color) -> void:
	material.set("shader_param/NEWCOLOR1",color)
	pass # Replace with function body.
