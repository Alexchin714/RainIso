extends KinematicBody

var path = []
var path_node = 0
var speed = 15

onready var nav = get_parent()
onready var player = get_owner().get_node("3dPlayer")

var health = 2

func _physics_process(delta):
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
			move_and_slide(direction.normalized() * speed, Vector3.UP)
	if health <= 0:
		$Particles.emitting = true
		$DeathPlayer.play("death")
		yield(get_tree().create_timer(1), "timeout")
		queue_free()
		
func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0

func _on_Timer_timeout():
	move_to(player.global_transform.origin)

func _on_Area_body_entered(body):
	player.hurt = true
	CrossHallItems.hp -= 1
