class_name Platform extends Area2D

export var door := ""

onready var animated_sprite : AnimatedSprite = $AnimatedSprite

signal pressed
signal unpressed


func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")


func _on_body_entered(body: PhysicsBody2D) -> void:
	if not body is Box:
		return
	animated_sprite.play("down")
	
	if door != "":
		Doors.id[door] = true
	
	emit_signal("pressed")


func _on_body_exited(body: PhysicsBody2D) -> void:
	if not body is Box:
		return
	animated_sprite.play("up")
	
	# PROBLEM: switching the level would trigger this
	# even though the platform is pressed.
	# As a result, I can't target doors in other scenes.
	if door != "" :
		Doors.id[door] = false

	emit_signal("unpressed")
