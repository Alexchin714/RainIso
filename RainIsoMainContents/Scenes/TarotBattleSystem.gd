extends CanvasLayer

signal ls
var lbl = 0
var wlbl = 0
var won = false
var lost = false
var tg = false

func _process(delta):
	$Container/YouBar.value = lbl
	$Container/WillowBar.value = wlbl
	$Container/YouBar/NumLabel.text = str(lbl)
	$Container/WillowBar/NumLabel.text = str(wlbl)
	if lbl > 250:
		lbl -= 1
	if wlbl > 250:
		lbl -= 1
	if lbl > 25 and lbl < 75:
		$AnimationPlayer.playback_speed = 1.5
	if lbl > 75 and lbl < 150:
		$AnimationPlayer.playback_speed = 2
	if lbl > 150 and lbl < 225:
		$AnimationPlayer.playback_speed = 2.75
	if lbl > 225:
		$AnimationPlayer.playback_speed = 3.65
	if lbl >= 250:
		Music.psycillow.stop()
		tg = false
		lbl -= 1
		won = true
		emit_signal("ls")
		$WinPlayer.play("win")
		$WillowTimer.stop()
		$OpenPlayer.play_backwards("openplayer")
		yield($OpenPlayer, "animation_finished")
		set_process(false)
	if wlbl >= 250:
		Music.psycillow.stop()
		tg = false
		wlbl -= 1
		emit_signal("ls")
		lost = true
		$WinPlayer.play("lost")
		$WillowTimer.stop()
		$OpenPlayer.play_backwards("openplayer")
		yield($OpenPlayer, "animation_finished")
		set_process(false)
	
func battle():
	randomize()
	set_process(true)
	lbl = 0
	wlbl = 0
	$OpenPlayer.play("openplayer")
	yield(get_tree().create_timer(1), "timeout")
	$WillowTimer.start()
	Music.psycillow.play()
	
func _input(event):
	if Input.is_action_just_pressed("ui_inspect") and $Container/FirstBar/Panel/RayCast2D.is_colliding():
		$BluePlayer.play("bluehighlight")
		$Score.play()
		lbl += randi()%2 + 1 
		$YouNumber.play("on")
	if Input.is_action_just_pressed("ui_inspect") and $Container/SecondBar/Panel/RayCast2D.is_colliding():
		$GreenPlayer.play("greenhighlight")
		$Score.play()
		lbl += randi()%2 + 1
		$YouNumber.play("on")
	if Input.is_action_just_pressed("ui_inspect") and $Container/ThirdBar/Panel/RayCast2D.is_colliding():
		$PurplePlayer.play("purplehighlight")
		$Score.play()
		lbl += randi()%3 + 1
		$YouNumber.play("on")
	
func _on_WillowTimer_timeout():
	wlbl += randi()%2 + 1
	$ScoreWillow.play()
	$WillowNumber.play("on")
	if !tg:
		$PhaseTimer.start()
		tg = true
	yield(get_tree().create_timer(1), "timeout")
	wlbl += randi()%2 + 1
	$ScoreWillow.play()
	$WillowNumber.play("on")
	yield(get_tree().create_timer(1), "timeout")
	wlbl += randi()%3 + 1
	$ScoreWillow.play()
	$WillowNumber.play("on")
	
func _on_PhaseTimer_timeout():
	$AnimationPlayer.play("tarots!")
