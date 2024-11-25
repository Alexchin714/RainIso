extends StaticBody

onready var timemation = get_owner().get_node("UI/TimeLabel/AnimationPlayer")
onready var player = get_node("../3dPlayer")
onready var playercam = player.get_node("SpringArm/Camera")
var inArea = false
var time = false

func _process(delta):
	if inArea == true and Input.is_action_just_pressed("mb_left"):
		if time == true:
			player.set_physics_process(false)
			player.visible = false
			playercam.current = false
			$Camera.current = true
			$AnimationPlayer.play("sleeping")
			CrossHallItems.sleep += 1
			CrossHallItems.isSleeping = true
			yield(get_tree().create_timer(2), "timeout")
			player.set_physics_process(true)
			player.visible = true
			playercam.current = true
			$Camera.current = false
			$AnimationPlayer.play("woke")
		if time == false:
			timemation.play("label")
			
func _on_Area_body_entered(body):
	inArea = true

func _on_Area_body_exited(body):
	inArea = false

func _on_Time_hourpass():
	time = true

func _on_Time_time():
	time = false
