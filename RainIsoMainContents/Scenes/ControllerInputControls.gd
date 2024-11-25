extends Control

const XBOX_BUTTON_TO_INDEX_MAPPING = {
	JOY_XBOX_A: 0,
	JOY_XBOX_B: 1,
	JOY_XBOX_X: 2,
	JOY_XBOX_Y: 3,
	JOY_START: 6,
	JOY_SELECT: 7
}

onready var icon = $Sprite
onready var name_label = $ActionName

var device_id = -1
