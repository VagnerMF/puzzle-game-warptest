extends Node

onready var anim = $Spiral/AnimationPlayer

# TODO parameters are for inputting different anims

func go_to_black(params=[]):
	get_tree().paused = true
	anim.play_backwards("Spiral")
	yield(anim, "animation_finished")
	$Spiral/Label.visible = true

func go_to_play(params=[]):
	$Spiral/Label.visible = false
	anim.play("Spiral")
	yield(anim, "animation_finished")
	get_tree().paused = false