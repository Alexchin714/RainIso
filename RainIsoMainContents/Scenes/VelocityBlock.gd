extends KinematicBody2D

const IDLE_DURATION = 1.0

export var move_to = Vector2.RIGHT * 121
export var speed = 20

var follow = Vector2.ZERO

onready var vb = $Sprite
onready var tween = $Tween

func _ready():
	set_physics_process(false)

func _on_Area2D_body_entered(body):
	$AnimationPlayer.play("Velocity")
	set_physics_process(true)

func _on_Area2D_body_exited(body):
	set_physics_process(false)
