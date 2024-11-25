extends Node

var mods = {}

func preloadMods():
	var path
	var dirMods = Directory.new()
	if Global.debug:
		path = "res://Mods/"
	else:
		path = "../"
	if dirMods.open(path) == OK:
		dirMods.list_dir_begin()
		var fileMod = dirMods.get_next()
		while fileMod != "":
			if ".gd" or ".frgo" in fileMod:
				Global.NodeModList.add_item(fileMod)
				var pathString = path + "%s//" % fileMod
				mods[fileMod] = load(pathString)
			fileMod = dirMods.get_next()

func loadMods(fileMod):
	var frgoMod = mods[fileMod].new()
	var structureMod = {}
	structureMod["frgo"] = frgoMod
	structureMod["script"] = frgoMod
	structureMod["update"] = false
	mods[fileMod] = structureMod
	
	if frgoMod.has_method("global_modification_update"):
		mods[fileMod]["update"] = true

func callInModMethod(mod, delta):
	mods[mod]["frgo"].call("global_modification_update", delta)
