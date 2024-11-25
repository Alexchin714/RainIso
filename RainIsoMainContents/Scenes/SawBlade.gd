extends Node2D

onready var timer = $Timer
onready var stimer = $StartingTimer

export (int) var follow_speed = 50

func _ready():
	visible = false
	$AnimationPlayer.play("SawBlade")
	
func _process(delta):
	$Path2D/PathFollow2D.offset += follow_speed * delta
	
func _on_Timer_timeout():
	follow_speed = 200
	$AnimationPlayer.play("Modulate")
	stimer.start()
	
func _on_StartingTimer_timeout():
	follow_speed = 50

func _on_Area2D_body_entered(body):
	pass

func _on_Optimizer_body_entered(body):
	visible = true
	$AnimationPlayer.play("SawBlade")
	
func _on_Optimizer_body_exited(body):
	visible = false

func _on_PathSpeed_body_entered(body):
	timer.start()
