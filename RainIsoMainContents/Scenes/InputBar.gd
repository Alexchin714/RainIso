extends Control

var nm = 0
onready var input = $Label
onready var ani = get_parent().get_node("AnimationPlayer")

func _process(delta):
	input.text = str(nm)
	if nm > 15:
		$TrainHorn.play()
		nm -= 1
		ani.play("trainend")
		yield(get_tree().create_timer(5), "timeout")
		SceneTransition.change_scene("res://RainIsoMainContents/Scenes/LevelSelectionScreen.tscn")
	if $Input/Arrow/RayCast2D.is_colliding() and Input.is_action_just_pressed("skillchecked"):
		nm += 1
		$Yes.play()
		$AnimationPlayer.playback_speed += .1
	elif !$Input/Arrow/RayCast2D.is_colliding() and Input.is_action_just_pressed("skillchecked"):
		nm = 0
		$No.play()
		$AnimationPlayer.playback_speed = 1
