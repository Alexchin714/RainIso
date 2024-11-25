extends Area2D

onready var timer = get_node("Timer")

func _on_SparkBubbles_body_entered(body):
	if body.name == "Player":
		body.hasDashed = false
		if Input.is_action_just_pressed("a"):
			body.velocity.x = -3000
			body.grabbed = false
			body.part = null
		if Input.is_action_just_pressed("d"):
			body.velocity.x = 3000
			body.grabbed = false
			body.part = null
