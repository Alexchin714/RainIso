extends Spatial

onready var animatronic_one = $PengooModel
onready var animatronic_two = $HappyModel
onready var animatronic_three = $FoxheardModel
onready var animatronic_four = $SeallyModel
onready var animatronic_five = $SanBerlyModel
onready var animatronic_six = $GoldenPengooModel
onready var animatronic_nine = $DabbyModel
onready var audio = $JumpscareSound
onready var cam = $Camera


func _ready():
	$PengooModel.hide()
	$HappyModel.hide()
	$FoxheardModel.hide()
	$SeallyModel.hide()
	$SanBerlyModel.hide()
	$GoldenPengooModel.hide()
	$DabbyModel.hide()
	cam.current = false

func _on_Animatronics_jumpscare(animatronic):
	match animatronic:
		"animatronic_one":
			yield(get_tree().create_timer(0.35), "timeout")
			animatronic_one.show()
			$PengooModel/AudioStreamPlayer3D.play()
			animatronic_one.get_node("AnimationPlayer").play("jumpscare")
		"animatronic_two":
			yield(get_tree().create_timer(0.35), "timeout")
			animatronic_two.show()
			animatronic_two.get_node("AnimationPlayer").play("jumpscare")
			$HappyModel/AudioStreamPlayer.play()
		"animatronic_three":
			yield(get_tree().create_timer(0.35), "timeout")
			$FoxheardModel/AudioStreamPlayer.play()
			animatronic_three.show()
			animatronic_three.get_node("AnimationPlayer").play("jumpscare")
		"animatronic_four":
			yield(get_tree().create_timer(0.35), "timeout")
			$SeallyModel/AudioStreamPlayer.play()
			animatronic_four.show()
			animatronic_four.get_node("AnimationPlayer").play("jumpscare")
		"animatronic_five":
			yield(get_tree().create_timer(0.35), "timeout")
			$SanBerlyModel/AudioStreamPlayer.play()
			animatronic_five.show()
			animatronic_five.get_node("AnimationPlayer").play("jumpscare")
		"animatronic_six":
			yield(get_tree().create_timer(0.35), "timeout")
			$GoldenPengooModel/AudioStreamPlayer.play()
			animatronic_six.show()
			animatronic_six.get_node("AnimationPlayer").play("jumpscare")
		"animatronic_nine":
			yield(get_tree().create_timer(0.35), "timeout")
			$DabbyModel/AudioStreamPlayer.play()
			animatronic_nine.show()
			animatronic_nine.get_node("AnimationPlayer").play("jumpscare")
			
	cam.current = true

func jumpscare_ended():
	get_tree().change_scene("res://RainIsoMainContents/Scenes/GameOver.tscn")
