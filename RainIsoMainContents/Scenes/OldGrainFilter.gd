extends ColorRect

func _ready():
	GlobalSettings.connect("show_ogf", self, "hideOldGrainFilter")
	
func hideOldGrainFilter(value):
	visible = value
