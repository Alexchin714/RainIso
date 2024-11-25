extends Node2D

const MIN_HEALTH: int = 23
var max_hp: int = 100

signal game_finished(result)

var map_node

var offensive = load("res://Offensives.gd")
var tsludge = load("res://Enemies/ThiefSludge.tscn")
var psludge = load("res://Enemies/PinkSludge.tscn")
var rbfsludge = load("res://Enemies/RedBeeferSludge.tscn")
var gbfsludge = load("res://Enemies/GreenBeeferSludge.tscn")
var bfsludge = load("res://Enemies/BeeferSludge.tscn")
var csludge = load("res://Enemies/CeramicSludge.tscn")
var bsludge = load("res://Enemies/BlueSludge.tscn")
var gsludge = load("res://Enemies/GreenSludge.tscn")
var sludge = load("res://Enemies/BlackSludge.tscn")
var instance
var ginstance
var binstance
var cinstance
var pinstance
var tinstance
var bfinstance
var gbfinstance
var rbfinstance

var build_mode = false
var build_valid = false
var build_tile
var build_location
var build_type

var cash = 100
var current_wave = 0
var enemies_in_wave = 0
var enemies_left = 0
var wave_mobs = [15, 30, 50]
var base_health = 100

onready var player: KinematicBody2D = get_parent().get_node("Player")
onready var health_bar: TextureProgress = get_node("UI/HUD/InfoBar/HP")
onready var health_bar_tween: Tween = get_node("UI/HUD/InfoBar/HP/Tween")

func _ready():
	map_node = get_node("RDTMap1")
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.connect("pressed", self, "initiate_build_mode", [i.get_name()])

func _physics_process(delta):
	$UI/HUD/InfoBar/InfoSorting/Money.text = "$ " + str(cash)
	
func _process(delta):
	if build_mode:
		update_tower_preview()

func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("lmbtower") and build_mode == true:
		verify_and_build()
		cancel_build_mode()
		
func start_next_wave():
	var wave_data = retrieve_wave_data()
	yield(get_tree().create_timer(0.2), "timeout")
	spawn_enemies(wave_data)
		
func retrieve_wave_data():
	var wave_data = [["BlackSludge", 1.0], ["BlackSludge", 1.0], ["BlackSludge", 1.0], ["BlackSludge", 1.0], ["BlackSludge", 1.0], ["BlackSludge", 1.0], ["BlackSludge", 1.0], ["GreenSludge", 1.0]]
	current_wave += 1
	enemies_in_wave = wave_data.size()
	return wave_data
	
func spawn_enemies(wave_data):
	$WaveTimer.start()
	for i in wave_data:
		var new_enemy = load("res://Enemies/" + i[0] + ".tscn").instance()
		new_enemy.connect("base_damage", self, "on_base_damage")
		map_node.get_node("Path").add_child(new_enemy, true)
		yield(get_tree().create_timer(i[1]), "timeout")
		
func add_cash(num):
	offensive.fire()
	cash += num
	
###Function Builds
func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = tower_type + "T1"
	build_mode = true
	get_node("UI").set_tower_preview(build_type, get_global_mouse_position())
	
func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("Deco").world_to_map(mouse_position)
	var tile_position = map_node.get_node("Deco").map_to_world(current_tile)
	
	if map_node.get_node("Deco").get_cellv(current_tile) == -1:
		get_node("UI").update_tower_preview(tile_position, "a0ffffff")
		build_valid = true
		build_location = tile_position
		build_tile = current_tile
	else:
		get_node("UI").update_tower_preview(tile_position, "ff186f")
		build_valid = false
		
func cancel_build_mode():
	build_mode = false
	build_valid = false
	get_node("UI/TowerPreview").free()
	
func verify_and_build():
	var tower_type
	var new_tower = load("res://Offensives/" + build_type + ".tscn").instance()
	new_tower.position = build_location
	new_tower.built = true
	new_tower.type = build_type
	new_tower.category = GameDataRdt.tower_data[build_type]["category"]
	map_node.get_node("Offensives").add_child(new_tower, true)
	map_node.get_node("Deco").set_cellv(build_tile, 5)

func _on_base_damage(damage):
	base_health -= damage
	if base_health <= 0:
		emit_signal("game_finished", false)
	else: 
		get_node("UI").update_health_bar(base_health)


func _on_WaveTimer_timeout():
	enemies_left = wave_mobs[current_wave]
	$MobTimer.start()
	
func _on_MobTimer_timeout():
	$BFTimer.start()
	binstance = bsludge.instance()
	ginstance = gsludge.instance()
	instance = sludge.instance()
	var path = map_node.get_node("Path")
	path.add_child(instance)
	path.add_child(ginstance)
	path.add_child(binstance)
	enemies_left -= 1
	if enemies_left <= 0:
		$MobTimer.stop()
		current_wave += 1
		if current_wave < len(wave_mobs):
			$WaveTimer.start()


func _on_HP_changed(damage):
	_on_base_damage(damage)


func _on_BFTimer_timeout():
	var path = map_node.get_node("Path")
	pinstance = psludge.instance()
	tinstance = tsludge.instance()
	cinstance = csludge.instance()
	path.add_child(cinstance)
	path.add_child(pinstance)
	path.add_child(tinstance)
	$GBFTimer.start()
	bfinstance = bfsludge.instance()
	path.add_child(bfinstance)


func _on_GBFTimer_timeout():
	var path = map_node.get_node("Path")
	$RBFTimer.start()
	pinstance = psludge.instance()
	tinstance = tsludge.instance()
	cinstance = csludge.instance()
	path.add_child(cinstance)
	path.add_child(pinstance)
	path.add_child(tinstance)
	gbfinstance = gbfsludge.instance()
	path.add_child(gbfinstance)


func _on_RBFTimer_timeout():
	var path = map_node.get_node("Path")
	rbfinstance = rbfsludge.instance()
	path.add_child(rbfinstance)
