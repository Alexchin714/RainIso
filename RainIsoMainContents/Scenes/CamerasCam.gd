extends Camera

func go():
	current = true

func stop():
	current = false

func change_cam(id : int):
	for i in $"../Cameras".get_children():
		i.hide()
	
	$"../Cameras".get_node("Cam" + str(id)).show()
