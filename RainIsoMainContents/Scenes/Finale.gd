extends Area2D

func _on_Finale_body_entered(body):
	RetroUnlocked.unlockedLevels += 1
	get_tree().change_scene("res://Retro/RetroTysm4Playing.tscn")
