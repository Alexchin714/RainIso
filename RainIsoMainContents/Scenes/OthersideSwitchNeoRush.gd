extends Area2D

export(int) var id = 128

var lock_portal = false

func do_lock():
	yield(get_tree().create_timer(0.1),"timeout")
	lock_portal = true
	yield(get_tree().create_timer(2),"timeout")
	lock_portal = false

func _on_OthersideSwitchNeoRush_body_entered(body):
	yield(get_tree().create_timer(0.13),"timeout")
	visible = false
	yield(get_tree().create_timer(15),"timeout")
	visible = true
