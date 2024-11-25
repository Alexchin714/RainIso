extends KinematicBody2D

onready var cloud_timer = $CloudTimer
onready var count_timer = $CountTimer

func _on_Area2D_body_entered(body):
	$CollisionShape2D.disabled = true
	count_timer.start()
	cloud_timer.start()
	$AnimationPlayer.play("CloudsAnimation")

func _on_CloudTimer_timeout():
	$AnimationPlayer.play_backwards("CloudsAnimation")


func _on_CountTimer_timeout(delta):
	$CollisionShape2D.disabled = false
	$CollisonShape2D.set_deferred("disabled",true)
