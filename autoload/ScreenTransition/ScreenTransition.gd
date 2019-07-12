extends Node

onready var Spiral = $Spiral/AnimationPlayer
onready var SpiralReverse = $SpiralReverse/AnimationPlayer

onready var anim = $Spiral/AnimationPlayer
onready var label = $Label

# TODO parameters are for inputting different anims

func go_to_black():
	get_tree().paused = true
	anim.play("Spiral")
	yield(anim, "animation_finished")
	label.visible = true

func go_to_play():
	label.visible = false
	SpiralReverse.play("SpiralReverse")
	yield(SpiralReverse, "animation_finished")
	get_tree().paused = false