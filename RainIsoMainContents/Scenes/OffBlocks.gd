extends StaticBody2D

var onb = preload("res://RainIsoMainContents/Resources/OffBlocks.png")
var onl = preload("res://RainIsoMainContents/Resources/OffOutline.png")
onready var spr = get_node("Sprite")

func _process(delta):
#	if GlobalLevel.onoff == false:
#		spr.set_texture(onb)
#		$CollisionShape2D.set_deferred("disabled", false)
#	if GlobalLevel.onoff == true:
#		spr.set_texture(onl)
#		$CollisionShape2D.set_deferred("disabled", true)
	pass
