extends StaticBody2D

func _on_Portal_body_entered(body):
	$Arrows.visible = false
	$ArrowsFlip.visible = true
	$ArrowsRotate.visible = false
	$ArrowsRotateFlip.visible = false
	if body.name == "Player":
		body.hasDashed = false
		body.velocity.x = -1600
		body.move_and_slide(body.velocity)
	$AnimationPlayer.play("ArrowsLeft")
	
func _on_Portal3_body_entered(body):
	$Arrows.visible = false
	$ArrowsFlip.visible = false
	$ArrowsRotate.visible = false
	$ArrowsRotateFlip.visible = true
	if body.name == "Player":
		body.hasDashed = false
		body.velocity.y = -900
		body.move_and_slide(body.velocity)
	$AnimationPlayer.play("ArrowsDown")
		
func _on_Portal2_body_entered(body):
	$Arrows.visible = true
	$ArrowsFlip.visible = false
	$ArrowsRotate.visible = false
	$ArrowsRotateFlip.visible = false
	if body.name == "Player":
		body.hasDashed = false
		body.velocity.x = 1600
		body.move_and_slide(body.velocity)
	$AnimationPlayer.play("ArrowsRight")
	
func _on_Portal4_body_entered(body):
	$Arrows.visible = false
	$ArrowsFlip.visible = false
	$ArrowsRotate.visible = true
	$ArrowsRotateFlip.visible = false
	if body.name == "Player":
		body.hasDashed = false
		body.velocity.y = 900
		body.move_and_slide(body.velocity)
	$AnimationPlayer.play("ArrowsUp")

func _on_Jump1_body_entered(body):
	pass # Replace with function body.

func _on_Jump2_body_entered(body):
	pass # Replace with function body.
