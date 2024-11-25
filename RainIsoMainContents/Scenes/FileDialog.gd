extends FileDialog

func refresh():
	self._draw()

func _draw():
	set_current_dir("user://Levels/")
