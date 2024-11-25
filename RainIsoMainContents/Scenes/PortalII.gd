extends Area2D

export(int) var id = 1

var lock_portal = false

func do_lock():
	lock_portal = true
	yield(get_tree().create_timer(1),"timeout")
	lock_portal = false
