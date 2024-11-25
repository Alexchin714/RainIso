extends Position2D

#var camSize = Vector2()
#var camPosition = Vector2()

#onready var parent = get_parent()

#func _ready():
	#camSize = OS.get_screen_size()
	#set_as_toplevel(true)
	#update_cam_position()
	
#func _physics_process(delta):
	#update_cam_position()
	
#func update_cam_position():
	#var x = round(parent.position.x / camSize.x)
	#var y = round(parent.position.y / camSize.y)
	#var newCamPosition = Vector2(x,y)
	#if camPosition == newCamPosition:
		#return
	
	#camPosition = newCamPosition
	#position = camPosition * camSize
