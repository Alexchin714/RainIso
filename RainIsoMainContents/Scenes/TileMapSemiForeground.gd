extends TileMap

var chunk_rect : Rect2 = Rect2(Vector2(-1.0, -1.0), Vector2(0.0, 0.0))

func _ready():
	add_to_group("map")
	
func _on_VisibilityNotifier2D_screen_entered():
	visible = true

func _on_VisibilityNotifier2D_screen_exited():
	visible = false
