extends Area2D

onready var ani = get_parent().get_node("AnimationPlayer")

func _on_Finale_body_entered(body):
	ani.play("finale")
