extends Light2D

func _ready():
	GlobalSettings.connect("shadows", self, "emitShadows")
	
func emitShadows(value):
	shadow_enabled = value
