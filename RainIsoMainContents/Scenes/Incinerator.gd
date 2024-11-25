extends KinematicBody2D

var player = preload("res://RainIsoMainContents/Scenes/Player.tscn")
var instance = player.instance()
var is_triggered = false
var gravity = 200
var velocity = Vector2()
	
func _on_AnimationPlayer_animation_finished(anim_name):
	set_physics_process(true)
	
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.wall_sliding = false
	$AnimationPlayer.play("Inci")
	$Timer.start()
	
func _on_Timer_timeout():
	pass

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		body.velocity.y = -300
	$Timer.stop()
	$AnimationPlayer.play_backwards("Inci")

func _on_CircleOfDeath_body_entered(body):
	if body.name == "Player":
		body.isDead()
