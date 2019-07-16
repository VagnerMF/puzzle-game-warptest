extends Node

onready var Spiral := $Spiral/AnimationPlayer
onready var SpiralReverse := $SpiralReverse/AnimationPlayer

onready var timer := $AnimBufferTimer
onready var label := $Label

# TODO parameters are for inputting different anims

func _ready():
	$Spiral.hide()
	$SpiralReverse.hide()
	print($Spiral/AnimationPlayer.get_autoplay())

func go_to_black():
	get_tree().paused = true
	$SpiralReverse.show()
	SpiralReverse.play_backwards("SpiralReverse")
	yield(SpiralReverse, "animation_finished")
	label.visible = true

func go_to_play():
	timer.start()
	yield(timer, "timeout") # Wait a minimum time to make the animation smoother
	label.visible = false
	$Spiral.show()
	$SpiralReverse.hide()
	Spiral.play("Spiral")
	yield(Spiral, "animation_finished")
	$Spiral.hide()
	get_tree().paused = false