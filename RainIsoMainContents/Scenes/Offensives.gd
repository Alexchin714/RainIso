extends Node2D

var slowmo_active = false
var category
var enemy_array = []
var built = false
var enemy
var type
var ready = true

export var normaltimescale = 1.0
export var slowmotimescale = 0.1

func _ready():
	if built:
		self.get_node("Range/CollisionShape2D").get_shape().radius = 0.5 * GameDataRdt.tower_data[type]["range"]
		
func _physics_process(delta):
	if enemy_array.size() != 0 and built:
		select_enemy()
		if not get_node("AnimationPlayer").is_playing():
			turn()
		if ready:
			fire()
	else:
		enemy = null
		
func turn():
	get_node("Sprite").look_at(enemy.position)
	
func select_enemy():
	var enemy_progress_array = []
	for i in enemy_array:
		enemy_progress_array.append(i.offset)
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	enemy = enemy_array[enemy_index]
	
		
func fire():
	var body
	ready = false
	if category == "tooth":
		fire_tooth()
	elif category == "cannon":
		fire_cannon()
	elif category == "freeze":
		freeze(body)
	enemy.on_hit(GameDataRdt.tower_data[type]["damage"])
	yield(get_tree().create_timer(GameDataRdt.tower_data[type]["rof"]), "timeout")
	ready = true

func fire_tooth():
	get_node("AnimationPlayer").play("Fire")
	
func fire_cannon():
	get_node("AnimationPlayer").play("Fire")
	
func freeze(body):
	pass
	
func _on_Range_body_entered(body):
	enemy_array.append(body.get_parent())
	
func _on_Range_body_exited(body):
	enemy_array.erase(body.get_parent())

func _on_FreezerTimer_timeout(body):
	pass
