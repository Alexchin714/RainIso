extends Node
class_name TurnQueue

onready var active_card

func initialize():
	var card_battler = get_battler()
	card_battler.sort_custom(self, 'sort_battler')
	for battler in card_battler:
		battler.raise()
	active_card = get_child(0)

static func sort_battlers(a,b):
	return a > b
	
func play_turn():
	yield(active_card.play_turn(), "completed")
	var new_index : int = (active_card.get_index() + 1)  % get_child_count()
	active_card = get_child(new_index)

func get_battler():
	pass
