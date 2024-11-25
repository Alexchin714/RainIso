extends Node

const debug = true
const UNIT_SIZE = 96

var checkpoint = false
var username
var score = 0
var player = null
var playing = false
var current_tile = 0
var cutsceneOn = false
var place_interactive_tile = false
var place_tile = false
var tile_size = 32
var playerpaused = false
var panera = 0
var pancakesCollected = 0
var coinsCollected = 0
var dropletCollected = 0
var requiredPancakes = 0

var filesystem_shown = false
var NodeModList
var funzone = RandomNumberGenerator.new()

func _ready():
	funzone.randomize()
	if OS.has_environment("USERNAME"):
		username = OS.get_environment("USERNAME")
	elif OS.has_environment("USER"):
		username = OS.get_environment("USER")
	else:
		username = "Clement"
	for mod in ModManager.mods:
		ModManager.loadMods(mod)
		
func _process(delta):
	for mod in ModManager.mods:
		if ModManager.mods[mod]["update"]:
			ModManager.callInModMethod(mod, delta)
