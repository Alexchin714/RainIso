extends Spatial

var cam

func _ready():
	cam = get_viewport().get_camera()
	
func _process(delta):
	var MakerPos = cam.unproject_position(self.global_transform.origin)
	$Node.position = MakerPos
