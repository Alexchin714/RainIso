extends Label

var drawTextSpeed : int = 0
var chatterLimit : int = 58

func showChatter():
	if drawTextSpeed < chatterLimit:
		drawTextSpeed += 1
		self.visible_characters = drawTextSpeed
