extends Sprite

func _ready():
	if DataManager.data["Objects"].has("CharacterBlackSelected"):
		$Node2D/Black.texture.resource_path = DataManager.data["Objects"]["CharacterBlackSelected"]

func _on_Character2_pressed():
	DataManager.data["Objects"][name] = $Node2D/Black.texture.resource_path
	DataManager.save_data()
