extends Button

signal bnum
var buttonnum = 0

func _process(delta):
	if buttonnum == 12:
		emit_signal("bnum")
		
func _on_ButtonButton_pressed():
	self.disabled = true
	buttonnum += 1
