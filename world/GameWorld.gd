class_name GameWorld extends Node2D

onready var Main := get_node("/root/Main")
signal exit_world

func _ready():
	connect("exit_world", Main, "return_to_title")

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_ESCAPE:
			emit_signal("exit_world")