extends TileMap

export var chunk_rect : Rect2 = Rect2(Vector2(-10, -10), Vector2(20.0, 20.0))
export var player : PackedScene

func _ready():
	add_to_group("map")
	#update_dirty_quadrants()
	
func _on_VisibilityNotifier2D_screen_entered():
	visible = true

func _on_VisibilityNotifier2D_screen_exited():
	visible = false
