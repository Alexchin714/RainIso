extends Sprite

func _ready():
	GlobalSettings.connect("vignette", self, "showVignette")
	
func showVignette(value):
	visible = value
