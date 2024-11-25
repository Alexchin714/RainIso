extends Sprite

func _ready():
	GlobalSettings.connect("hide_backdrop", self, "hBD")
	
func hBD(value):
	self.visible = value
