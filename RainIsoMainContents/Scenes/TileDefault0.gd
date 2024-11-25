extends Node2D

var speed = 256
var tile_size = 16

var last_position = Vector2()
var target_position = Vector2()
var movedir = Vector2()

func _ready():
	position = position.snapped(Vector2(tile_size, tile_size))
	last_position = position
	target_position = position

func _process(delta):
	position += speed * movedir * delta
	
	if position.distance_to(last_position) >= tile_size - speed * delta:
		position = target_position
		
	if position == target_position:
		get_movedir()
		last_position = position
		target_position += movedir * tile_size
		
func get_movedir():
	if movedir.x != 0 && movedir.y != 0:
		movedir = Vector2.ZERO

func _on_OBJCOLOR_color_changed(color : Color) -> void:
	material.set("shader_param/NEWTILECOLOR1",color)
	pass # Replace with function body.


