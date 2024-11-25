extends Sequencer

func _ready():
	GlobalSettings.connect("secondfilter", self, "SecondFilter")
	
func SecondFilter(value):
	#$HalfToneFilter.visible = value
	#$KuwaharaFilter.visible = value
	pass
