extends Node2D

const IDLE_DURATION = 1.0

export var move_to = Vector2.RIGHT * 32
export var speed = 2

var follow = Vector2.ZERO

onready var neorush = $NeoRush
onready var tween = $Tween

func _ready():
	_init_tween()
	
func _init_tween():
	var duration = move_to.length() / float(speed * Global.UNIT_SIZE)
	tween.interpolate_property(self, "follow", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	tween.interpolate_property(self, "follow", move_to, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + IDLE_DURATION * 2)
	tween.start()
	
func _physics_process(delta):
	neorush.position = neorush.position.linear_interpolate(follow, 1)
