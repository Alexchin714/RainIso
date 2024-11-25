extends KinematicBody

export var speed = 15

var health = 4
var path = []
var cur_path_idx = 0
var velocity = Vector3.ZERO
var threshold = .1

onready var nav = get_parent()
onready var player = get_owner().get_node("3dPlayer")

func _physics_process(delta):
	if path.size() > 0:
		move_to_target()
	if health <= 0:
		$DeathPlayer.play("death")
		yield(get_tree().create_timer(1), "timeout")
		queue_free()
		
func move_to_target():
	if global_transform.origin.distance_to(path[cur_path_idx]) < threshold:
		path.remove(0)
	else:
		var direction = path[cur_path_idx] - global_transform.origin
		velocity = direction.normalized() * speed
		move_and_slide(velocity, Vector3.UP)
		
func get_target_path(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	
func _on_AreaHurtbox_body_entered(body):
	player.hurt = true
