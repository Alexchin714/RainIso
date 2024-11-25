extends CanvasLayer

onready var hook = get_owner().get_node("Label/FishingHook/AnimationPlayer")
signal done

func _input(event):
	if $Fishing/ProgressBar/RayCast2D.is_colliding() and event.is_action_pressed("ui_accept"):
		emit_signal("done")
