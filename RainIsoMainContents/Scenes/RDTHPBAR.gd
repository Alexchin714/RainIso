extends TextureRect

func _ready():
	$HP.value = 100
	
func set_percent_value_int(value):
	$HP.value = value

