extends Node

var timer_on = false
var time = 0
var config = true

func enable():
	timer_on = true
	
func disable():
	timer_on = false
	
func reset():
	time = 0
	timer_on = false
