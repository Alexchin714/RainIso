extends Control

var pressed

signal laptop_on
signal laptop_off
	
func _process(delta):
	if $Exposure.value > 100:
		get_tree().change_scene("res://RainIsoMainContents/Scenes/GameOver.tscn")
		
func _on_LaptopButton_pressed():
	pressed = !pressed
	if pressed:
		emit_signal("laptop_on")
	if !pressed:
		emit_signal("laptop_off")

func _on_CrossLaptop_press():
	pressed = false

func _on_Shrooms_exposure_twins():
	$Exposure.value += 25

func _on_Shrooms_exposure_shrooms():
	$Exposure.value += 25
