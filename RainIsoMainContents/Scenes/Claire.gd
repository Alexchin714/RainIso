extends KinematicBody2D

var attackThreshold = 0
var attack = ["SpearShot", "GunShots", "SpearStraightShot"]
var idleCount = 0
var attackSet = attack
var hp = 300
var damage = 1
var dead = false
var activate = false
var dash = false
var idle = false
var bossmode = false
var lunge = false

var velocity = Vector2(0,0)
export var steerForce = 50
export var limit_speed_y = 2400
export var gravity = 35
export var jumpForce = -1200
export var speed = 300
export var speedHoming = 8000
export var dashSpeed = 1000

var playerDir
var playerPosition
var targetPosition

var homingPosition
var targetsPosition

var turning = false
var jumpBufferTimer = 0

var ins = false

onready var animtree = $AnimationTree
onready var player = get_owner().get_node("Player")

func _ready():
	randomize()
	
func _physics_process(delta):
	gunLookAt(delta)
	if bossmode:
		#if !$Body/Sprite/LeftRay.is_colliding() and !$Body/Sprite/RightRay.is_colliding():
		follow(delta)
		#if $Body/Sprite/LeftRay.is_colliding() and $Body/Sprite/RightRay.is_colliding():
		#	var statemachine = animtree.get("parameters/playback")
		#	animtree.travel("SpearDash")
		
	if ins == true:
		jump(delta)
		ins = false
		
	#if lunge == true:
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
		
func _process(delta):
	if hp < 1:
		dead = true
	if dead == true:
		dead = false
		$DeathPlayer.play("ScenesDead")
		$BattleAnimationPlayer.stop()
		$AnimationPlayer.stop()
		yield(get_tree().create_timer(1), "timeout")
		queue_free()
		
func increaseIdleCount():
	if bossmode:
		idleCount += 1
	
		if idleCount > attackThreshold:
			idleCount = 0
			attacker()
		
func gunLookAt(delta):
	playerDir = get_owner().get_node("Player").global_position - global_position
	$Body/GunNode.global_rotation = lerp($Body/GunNode.global_rotation, playerDir.angle(), delta * 4)
	
func follow(delta):
	var player_direction = player.position - self.position
	player_direction.y = 0
	move_and_slide(speed * player_direction.normalized())
	if player_direction.x > 0:
		$Body/Sprite.flip_h = false
	if player_direction.x < 0:
		$Body/Sprite.flip_h = true
		
func jump(delta):
	velocity.y = jumpForce
	
func attacker():
	var attacks = attackSet[randi()%attackSet.size()]
	animtree.set_condition(attacks, true)
	
func ins():
	ins = true
	
func lunger():
	lunge = true
	
func _on_SpearArea_body_entered(body: KinematicBody2D):
	player.isHurt()
	pass

func _on_Head_body_entered(body: KinematicBody2D):
	$AnimationPlayerMelee.play("melee")

func _on_GunArea_body_entered(body: KinematicBody2D):
	player.isHurt()
	pass

func detectTurnAround():
	if $Body/Sprite/Ray.is_colliding():
		turning = !turning
		scale.x = -scale.x

func _on_RayArea_body_entered(body: KinematicBody2D):
	animtree.set("parameters/conditions/SpearDash", true)
