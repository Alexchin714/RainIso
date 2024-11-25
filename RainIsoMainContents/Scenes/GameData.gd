extends Node

var card_data = {}
var item_rarity_distribution = {
	"Common": 10,
	"Uncommon": 7,
	"Rare": 5,
	"Epic" : 3,
	"Legendary": 2,
	"Death": 1}
var item_stats = ["Attack", "Defence", "Health", "Block"]
var item_scaling_stats = ["Attack", "Defence"]

func _ready():
	var item_data_file = File.new()
	item_data_file.open("res://Data/CardStats.json", File.READ)
	var item_data_json = JSON.parse(item_data_file.get_as_text())
	item_data_file.close()
	card_data = item_data_json.result
