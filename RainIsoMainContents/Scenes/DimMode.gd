extends CanvasLayer

func _ready():
	GlobalSettings.connect("dim_mode", self, "dim")

func dim(value):
	$Sprite.visible = value
