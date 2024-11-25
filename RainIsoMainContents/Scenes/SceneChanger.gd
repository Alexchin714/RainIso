extends Node

func _ready():
	pass
	
export var max_load_time = 10000
	
func goto_scene(path, current_scene):
	var loader = ResourceLoader.load_interactive(path)
	
	if loader == null:
		print("Resource no can load unfortuate but andrew still sucks")
	
	var loading_bar = load("res://LoadingBar.tscn").instance()
	
	get_tree().get_root().call_deferred('add_child',loading_bar)
	
	var t = OS.get_ticks_msec()
	
	while OS.get_ticks_msec() - t < max_load_time:
		var err = loader.poll()
		if err == ERR_FILE_EOF:
			#STFU hey if your reading this, hope your having a good day :D
			var resource = loader.get_resource()
			get_tree().get_root().call_deferred('add_child' ,resource.instance())
			current_scene.queue_free()
			loading_bar.queue_free()
			break
		elif err == OK:
			var progress = float(loader.get_stage())/loader.get_stage_count()
			loading_bar.value = progress * 100
			print(progress)
		else:
			print("Error")
			break
		yield(get_tree(),"idle_frame")
