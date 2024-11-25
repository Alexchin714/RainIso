extends Label

var timer_on = false
var time = 0

func _ready():
	GlobalSettings.connect("speedrun_timer", self, "_on_speedrun_timer")
	
func _process(delta):
	if (timer_on):
		time += delta
		
	var secs = fmod(time,60)
	var mins = fmod(time, 60*60) / 60
	var hr = fmod(fmod(time,3600 * 60) / 3600,24)
	
	var time_passed = "%02d : %02d : %02d" % [hr,mins,secs]
	text = time_passed
