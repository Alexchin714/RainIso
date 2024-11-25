extends Control

func setSlot(filenameStr, texture, dateClockStr, character):
	$SaveSlotsBuild.texture = texture
	$Label.text = filenameStr
	$New.text = dateClockStr
	$Character.texture = character

func partialModulate(color):
	$SaveSlotsBuild.set_modulate(color)
	$Label.set_modulate(color)
	$New.set_modulate(color)
	
func getFilename():
	return $Label.text
