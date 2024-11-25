extends Spatial

onready var game = get_tree().get_root().get_node("TNAPN1")

func _on_LampButton_button_down():
	if game.out_of_power: return
	$Lamp.close()
	game.lamp = false
	
func _on_LampButton_button_up():
	$Lamp.open()
	game.lamp = true

func _on_Power_out_of_power():
	$Lamp.leak()
	game.lamp = true
