extends CanvasLayer

var acce = 0
	
func _ready():
	GlobalSettings.connect("colorblind", self, "colorblindnessControl")
	
func colorblindnessControl(value):
	acce = value
	if acce == 0:
		$AccessibilityPlayer.play("0")
	elif acce == 1:
		$AccessibilityPlayer.play("1")
	elif acce == 2:
		$AccessibilityPlayer.play("2")
	elif acce == 3:
		$AccessibilityPlayer.play("3")
