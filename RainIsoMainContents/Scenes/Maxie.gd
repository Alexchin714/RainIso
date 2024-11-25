extends KinematicBody2D

var attackThreshold = 0
var attack = ["Beam", "Orb", "StarStruck"]
var idleCount = 0
var attackSet = attack
var hp = 300
var damage = 1
var dead = false
var activate = false

var velocity = Vector2(0,0)
var gravity = 1000
var jumpForce = -600

onready var animtree = $AnimationTree

onready var player = get_owner().get_node("Player")
onready var bounceball = preload("res://RainIsoMainContents/Scenes/MaxieBounceBalls.tscn")
onready var orb = preload("res://RainIsoMainContents/Scenes/Orb.tscn")

func _ready():
	randomize()
	
func _physics_process(delta):
	if hp < 1:
		dead = true
	if dead == true:
		dead = false
		$DeathPlayer.play("ScenesDead")
		$AnimationPlayer.stop()
		yield(get_tree().create_timer(1), "timeout")
		queue_free()
	velocity.y -= gravity
	velocity = move_and_slide(velocity * Vector2.UP)
	
func increaseIdleCount():
	idleCount += 1
	
	if idleCount > attackThreshold:
		idleCount = 0
		attack()
		
func start():
	$AnimationPlayer.play("SETUP")
	
func attack():
	var attacks = attackSet[randi()%attackSet.size()]
	animtree.set_condition(attacks, true)
	
func orbinstance():
	var projectile = orb.instance()
	
	get_parent().add_child(projectile)
	
	projectile.velocity = projectile.position
	
	yield(get_tree().create_timer(1), "timeout")
	projectile.queue_free()
	
func _on_Area2D_body_entered(body):
	$DamagedPlayer.play("damaged")
	hp -= 5
	$MaxieHealthBar/ProgressBar.value -= 5

func interpolate():
	$Tween.interpolate_property(self, "position", position, player.position, 0.4, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()
	scale.x = -scale.x
