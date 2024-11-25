extends MarginContainer

var settings

func _on_multiplayer_menu_back_button_pressed() -> void:
	$Click.play()
	$MultiplayerMenu.visible = false
	$MainMenu.visible = true
	
func _on_exit_menu_back_button_pressed() -> void:
	$Click.play()
	$Exitmenu.visible = false
	$MainMenu.visible = true
	
func _on_exit_menu_exit_button_pressed() -> void:
	$click.play()
	yield(get_tree().create_timer(.2), "timeout")
	get_tree().quit()
	
func _on_options_menu_back_button_pressed() -> void:
	$click.play()
	$options_menu.visible = false
	$main_menu.visble = true

func _on_options_menu_music_audio_changed() -> void:
	if settings.music_enabled:
		if $main_menu/main_music.playing:
			$main_menu/main_music.volume_db = settings.music_volume - 15
		else:
			$main_menu/main_music.play()
			$main_menu/main_music.volume_db = settings.music_volume - 15
	else:
		$main_menu/menu_music.stop()
