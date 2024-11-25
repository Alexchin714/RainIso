extends Spatial

onready var anim = $AnimationPlayer

func _on_MonitorUI_monitor_off():
	anim.play("MonitorDown")

func _on_MonitorUI_monitor_on():
	anim.play("MonitorUp")
