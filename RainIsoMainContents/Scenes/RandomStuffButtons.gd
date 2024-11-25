extends Spatial

onready var l1 = $RandomText/Disc
onready var l2 = $RandomText/Flower
onready var l3 = $RandomText/Soda
onready var l4 = $RandomText/Monitor
onready var l5 = $RandomText/Draw1
onready var l6 = $RandomText/Draw2
onready var l7 = $RandomText/paper

func _on_Button_button_down():
	$RandomText/AnimationPlayer.play("clicked")
	l1.visible = true
	l2.visible = false
	l3.visible = false
	l4.visible = false
	l5.visible = false
	l6.visible = false
	l7.visible = false

func _on_Button2_button_down():
	$RandomText/AnimationPlayer.play("clicked")
	l1.visible = false
	l2.visible = true
	l3.visible = false
	l4.visible = false
	l5.visible = false
	l6.visible = false
	l7.visible = false
	
func _on_Button3_button_down():
	$RandomText/AnimationPlayer.play("clicked")
	l1.visible = false
	l2.visible = false
	l3.visible = true
	l4.visible = false
	l5.visible = false
	l6.visible = false
	l7.visible = false
	
func _on_Button4_button_down():
	$RandomText/AnimationPlayer.play("clicked")
	l1.visible = false
	l2.visible = false
	l3.visible = false
	l4.visible = true
	l5.visible = false
	l6.visible = false
	l7.visible = false
	
func _on_Button5_button_down():
	$RandomText/AnimationPlayer.play("clicked")
	l1.visible = false
	l2.visible = false
	l3.visible = false
	l4.visible = false
	l5.visible = true
	l6.visible = false
	l7.visible = false
	
func _on_Button6_button_down():
	$RandomText/AnimationPlayer.play("clicked")
	l1.visible = false
	l2.visible = false
	l3.visible = false
	l4.visible = false
	l5.visible = false
	l6.visible = true
	l7.visible = false
	
func _on_Button7_button_down():
	$RandomText/AnimationPlayer.play("clicked")
	l1.visible = false
	l2.visible = false
	l3.visible = false
	l4.visible = false
	l5.visible = false
	l6.visible = false
	l7.visible = true
