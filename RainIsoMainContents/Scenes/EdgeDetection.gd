extends ColorRect

func _ready():
	GlobalSettings.connect("edge_detection", self, "edgeDetection")
	
func edgeDetection(value):
	visible = value
