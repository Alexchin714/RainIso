extends Node2D

var dragging = false
var selected = []
var drag_start = Vector2.ZERO
var select_rect = RectangleShape2D.new()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			if selected.size() == 0:
				dragging = true
				drag_start = event.position
		elif dragging:
			dragging = false
	if event is InputEventMouseMotion and dragging:
		update()

func _draw():
	if dragging:
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start),
		Color(.5, .5, .5), false)
