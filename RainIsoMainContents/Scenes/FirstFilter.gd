extends Sequencer

func _ready():
	GlobalSettings.connect("firstfilter", self, "FirstFilter")

func FirstFilter(value):
	$MosaicFilter.visible = value
	$DitherFilter.visible = value
