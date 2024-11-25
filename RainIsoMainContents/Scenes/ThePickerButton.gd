extends HBoxContainer

export(String) var buttonName
signal change(direction)

func _ready():
	$Label.text = buttonName

func _on_OneLeftComp_pressed():
	emit_signal('change', -1)


func _on_OneRightComp_pressed():
	emit_signal('change', 1)
