extends Node2D

signal room_changed(old_room, new_room)

onready var _player: Player = $Player
onready var _camera: Camera2D = _player.get_camera()
onready var _rooms: Array = $Rooms.get_children()
	
func _ready():
	GlobalSettings.connect("gdm", self, "batchDetail")
	
func _process(delta: float) -> void:
	for room in _rooms:
		if room != _player.currRoom and _player_in_room(_player, room):
			_player.prevRoom = _player.currRoom
			_player.currRoom = room
			
			_player.prevRoom.pause()
			_camera.transition(_player.prevRoom, _player.currRoom)
			yield(_camera, 'transition_completed')
			_player.currRoom.resume()

			emit_signal('room_changed', _player.prevRoom, _player.currRoom)
			
func _player_in_room(player: Player, room: Room2D) -> bool:
	var bounds := Rect2(room.get_global_position(), room.get_room_dimensions())

	return bounds.has_point(player.get_global_position())

func _on_HazardArea_body_entered(body):
	_player.isDead()

func batchDetail():
	pass
