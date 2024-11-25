extends "res://PlayerStats.gd"

func enter(player: Player, previous_state_dict: Dictionary) -> void:
	player.velocity = Vector2.ZERO

	player.reset_dash()
	player.reset_jump()

func handle_input(player: Player, event: InputEvent) -> Dictionary:
	if event.is_action_pressed("jump") and player.can_jump():
		return {'new_state': Player.State.JUMP}
		player.get_animation_player().queue("IDLE1")
	elif event.is_action_pressed("dash") and player.can_dash():
		if player.get_dash_cooldown_timer().is_stopped():
			return {'new_state': Player.State.DASH}

	return {'new_state': Player.State.NO_CHANGE}

func update(player: Player, delta: float) -> Dictionary:
#	if Util.get_input_direction() != Util.Direction.NONE:
#		return {'new_state': Player.State.WALK}

	if player.is_in_air():
		return {'new_state': Player.State.FALL}

	player.move(Vector2(0, 10))

	return {'new_state': Player.State.NO_CHANGE}
