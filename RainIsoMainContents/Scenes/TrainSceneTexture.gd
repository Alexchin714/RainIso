extends TextureRect

export(float) var scrollSpeed = 0.4

func _ready():
	self.material.set_shader_param("scrollSpeed", scrollSpeed)
