extends Sprite

export(int) var TEXTURE_VARIATIONS_AMOUNT: int = 3
export(int) var TEXTURE_WIDTH: int = 32

func _ready():
	variate_texture()

func variate_texture():
	if TEXTURE_VARIATIONS_AMOUNT > 1:
		var skips: int = randi() % TEXTURE_VARIATIONS_AMOUNT
		region_rect.position.x += skips * TEXTURE_WIDTH
