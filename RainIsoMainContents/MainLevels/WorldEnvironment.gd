extends WorldEnvironment

func _ready():
	GlobalSettings.connect("enableAdjust", self, "enableAdjustment_")
	GlobalSettings.connect("gamma", self, "gammae")
	GlobalSettings.connect("post_processing", self, "post_process")
	
func post_process(value):
	environment.glow_enabled = value

func gammae(value):
	environment.adjustment_saturation = value

func enableAdjustment_(value):
	environment.adjustment_enabled = value
