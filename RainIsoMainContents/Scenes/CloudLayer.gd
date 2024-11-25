extends ParallaxLayer

export(float) var Cloud_Speed = 45

func _process(delta):
	self.motion_offset.x += Cloud_Speed * delta
