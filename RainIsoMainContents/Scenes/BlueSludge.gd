extends PathFollow2D

signal base_damage(damage)

var speed = 65
var hp = 30
var base_damage = 5

onready var impact_area = get_node("Impact")
var projectile_impact = preload("res://ProjectileImpact.tscn")

func _physics_process(delta):
	if unit_offset == 1.0:
		emit_signal("base_damage", base_damage)
		queue_free()
	move(delta)
	
func move(delta):
	set_offset(get_offset() + speed * delta)

func on_hit(damage):
	impact()
	hp -= damage
	if hp <= 0:
		on_destroy()
		
func impact():
	randomize()
	var x_pose = randi() % 31
	randomize()
	var y_pose = randi() % 31
	var impact_location = Vector2(x_pose, y_pose)
	var new_impact = projectile_impact.instance()
	new_impact.position = impact_location
	impact_area.add_child(new_impact)
	
func on_destroy():
	get_node("KinematicBody2D").queue_free()
	yield(get_tree().create_timer(0.2), "timeout")
	self.queue_free()

