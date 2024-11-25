extends CanvasLayer
		
var isAct1 = false
var isAct2 = false
var isAct3 = false
var isAct4 = false
var act1select = 0
var act2select = 0
var act3select = 0
var act4select = 0

func _ready():
	isAct1 = true
	
func _input(event):
	if isAct1:
		#if Input.is_action_just_pressed("a"):
		#	act1select -= 1
		#	if act1select >= 4:
		#		act1select = 0
		#	elif act1select <= -1:
		#		act1select = 3
		#	selectorNihilogueBack()
		if Input.is_action_just_pressed("d"):
			act1select += 1
			if act1select >= 4:
				act1select = 0
			elif act1select <= -1:
				act1select = 3
			selectorNihilogue()
	if Input.is_action_just_pressed("esc"):
		SceneTransition.change_scene("res://RainIsoMainContents/Scenes/TitleScreen.tscn")
			
func _on_MelodyTownArea_body_entered(body):
	pass # Replace with function body.

func _on_LeftArrow_pressed():
	$Audio/ActSFX.play()
	
func _on_RightArrow_pressed():
	$Audio/ActSFX.play()

func _on_MelodyTownButton_pressed():
	$Audio/SelectedSFX.play()

func _on_NeoRushCityButton_pressed():
	$Audio/SelectedSFX.play()

func _on_LavaHillButton_pressed():
	$Audio/SelectedSFX.play()

func _on_Act1_pressed():
	$TheActsList/AnimationPlayer.play("transition")

func selectorNihilogue():
	if act1select == 0:
		$Slots/Act1/AnimationPlayer.play("prologue")
	elif act1select == 1:
		$Slots/Act1/AnimationPlayer.play("melodytown")
	elif act1select == 2:
		$Slots/Act1/AnimationPlayer.play("neorushcity")
	elif act1select == 3:
		$Slots/Act1/AnimationPlayer.play("lavarush")

func selectorNihilogueBack():
	if act1select == 0:
		$Slots/Act1/AnimationPlayer.play("prologueBack")
	elif act1select == 1:
		$Slots/Act1/AnimationPlayer.play("melodytownBack")
	elif act1select == 2:
		$Slots/Act1/AnimationPlayer.play("neorushcityBack")
	elif act1select == 3:
		$Slots/Act1/AnimationPlayer.play("lavarushBack")
