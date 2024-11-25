extends Light2D
class_name PaleLight2D,"res://RainIsoMainContents/CustomNodes/CustomNodeIcon/PaleLight2D.png"

func _ready():
	$PointLightIcon.visible = false
	GlobalSettings.connect("shadows", self, "emitShadows")
	
func emitShadows(value):
	shadow_enabled = value
