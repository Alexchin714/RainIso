extends Area2D



func _on_KOLLadders_body_entered(body):
	if body.name == "KOLPlayer":
		get_node("../KOLPlayer").ladder_on = true

func _on_KOLLadders_body_exited(body):
	if body.name == "KOLPlayer":
		get_node("../KOLPlayer").ladder_on = false
