extends CanvasLayer

func _process(delta):
	Global.panera = $Panera/Label.text

func openInventory():
	$Main.visible = true
