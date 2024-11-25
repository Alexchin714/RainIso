extends KinematicBody2D

onready var cc = $CollectableCollect

func _on_Collider_body_entered(body):
	Global.pancakesCollected += 1
	$AnimationPlayer.play("collected")
	yield(get_tree().create_timer(1.2), "timeout")
	queue_free()
