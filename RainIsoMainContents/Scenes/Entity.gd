extends Node2D

export(int) var maxHp: int = 10
export(int) var hp: int = maxHp

var isDamage = false
var hit = false

export(int) var SPEED: int = 75

func _ready():
	$AnimationPlayer.play("idle")
	
func _process(delta):
	if hit == true:
		$AnimationPlayer.play("hit")
		hp -= 5
		hit = false
		yield(get_tree().create_timer(0.4), "timeout")
		isDamage = false
		
	if isDamage == false and hp > 0:
		$AnimationPlayer.play("idle")
	if hp < 1:
		$AnimationPlayer.play("damaged")
		yield(get_tree().create_timer(1), "timeout")
		queue_free()
	
func _on_Area2D_body_entered(body):
	print("Collide")
	#Global.battlestart = true
