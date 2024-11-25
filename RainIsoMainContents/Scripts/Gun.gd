extends Spatial

export var dmg : int
 
export var ammo : int
export var max_ammo : int
export var spare_ammo :int 
 
export var ammo_per_shot : int 
export var inf_spare_ammo : bool
 
export var shotgun : bool
export var full_auto : bool
 
export var reload_time : float
export var firerate : float
 
export var shotgun_spread : float
 
export var ray_cast : NodePath
onready var player = get_node("../Player")
onready var raycast = get_node(ray_cast)
 
var can_shoot = true
var reloading = false
 
var paused = false
 
func _ready():
	randomize()
 
func _physics_process(delta):
	if Input.is_action_just_pressed("look_up"):
		self.visible = false
	
func _process(delta):
	if ammo <= 0:
		can_shoot = false
	
	if Input.is_action_just_pressed("climb") && reloading == false && paused == false:
		reload()
	
	if Input.is_action_pressed("Hooked") && can_shoot == true && full_auto == true && paused == false:
		if shotgun == false:
			shoot()
		else:
			shotgun_shoot()
	elif Input.is_action_just_pressed("Hooked") && can_shoot == true && full_auto == false && paused == false:
		if shotgun == false:
			shoot()
		else:
			shotgun_shoot()
	
func shoot():
	can_shoot = false
	ammo -= ammo_per_shot
	
	if raycast.get_collider() != null && raycast.get_collider().is_in_group("enemy"):
		raycast.get_collider().hp -= dmg
		print("print")
		
	if $AnimationPlayer != null:
		$AnimationPlayer.stop(true)
		$AnimationPlayer.play("shoot")
	
	yield(get_tree().create_timer(firerate), "timeout")
	
	if reloading == false:
		can_shoot = true
 
 
 
 
func shotgun_shoot(): 
	can_shoot = false
	ammo -= ammo_per_shot
	
	for i in range(8):
		raycast.rotation_degrees.y = rad2deg(rand_range(shotgun_spread, -shotgun_spread))
		raycast.rotation_degrees.x = rad2deg(rand_range(shotgun_spread, -shotgun_spread))
		yield(get_tree().create_timer(0.005), "timeout")
		if raycast.get_collider() != null && raycast.get_collider().is_in_group("enemy"): # the change the enemy group to what ever you are using
			raycast.get_collider().hp -= dmg
	
	raycast.rotation_degrees.x = 0
	raycast.rotation_degrees.y = 0
	
	$AudioStreamPlayer.play()
	
	if $AnimationPlayer != null:
		$AnimationPlayer.stop(true)
		$AnimationPlayer.play("shoot")
	
	yield(get_tree().create_timer(firerate), "timeout")
	if reloading == false:
		can_shoot = true
 
func reload():
	reloading = true
	can_shoot = false
	
	if $AnimationPlayer != null:
		$AnimationPlayer.play("reload")
	
	yield(get_tree().create_timer(reload_time), "timeout")
	
	if inf_spare_ammo == false:
		
		var tmp_ammo
		
#       spare_ammo -= max_ammo - ammo
		
		if spare_ammo < max_ammo:
			tmp_ammo = ammo + spare_ammo
			if max_ammo - tmp_ammo >= 0:
				ammo += spare_ammo
				spare_ammo = 0
			else:
				ammo += spare_ammo
				ammo += max_ammo - tmp_ammo
				spare_ammo = -(max_ammo - tmp_ammo)
		else:
			spare_ammo -= max_ammo - ammo
			ammo = max_ammo
	
	else:
		ammo = max_ammo
	
	if ammo > 0:
		can_shoot = true
	reloading = false
