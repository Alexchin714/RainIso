extends Control

var progressing = false
var progressbar = 0

func _process(delta):
	if progressing == true:
		progressbar += .1
	if progressing == false:
		progressbar -= 1
	if progressbar < 0:
		progressbar += 1
	if progressbar > 100:
		progressbar += 1
	$ComputerSlider/Bar.value = progressbar

func _on_ComputerTrashButton_pressed():
	$ComputerTrashFile.visible = true


func _on_ComputerNotesButton_pressed():
	$ComputerNote.visible = true


func _on_ComputerCrashButton_pressed():
	get_tree().quit()


func _on_ComputerFolderButton_pressed():
	$ComputerFile.visible = true


func _on_Button_pressed():
	$ComputerFile.visible = false


func _on_TrashButton_pressed():
	$ComputerTrashFile.visible = false


func _on_NoteButton_pressed():
	$ComputerNote.visible = false


func _on_ComputerTrashFile_check_on():
	pass # Replace with function body.


func _on_X_pressed():
	$ComputerSlider.visible = false

func _on_StartButton_button_down():
	progressing = true

func _on_StartButton_button_up():
	progressing = false

func _on_ComputerSliderButton_pressed():
	$ComputerSlider.visible = true

func _on_ComputerButtonButton_pressed():
	$ComputerButton.visible = true
