extends CanvasLayer

var strl = 0
onready var strling = $UI/StrLabel
onready var ani = $AnimationPlayer
onready var addr = $Adder

func add():
	strl += 1
	strling.text = str(strl)
	
func open():
	ani.play("pancakeson")
	
func close():
	ani.play("pancakesoff")
