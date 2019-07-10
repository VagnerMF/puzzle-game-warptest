class_name TitleScreen extends Control

onready var Main := get_node("/root/Main")
signal new_game

func _ready():
	connect("new_game", Main, "start_new_game")

func _input(event):
	if event is InputEventKey and event.pressed:
		#get_tree().change_scene("res://world/World.tscn")
		emit_signal("new_game")

func _on_StartButton_pressed():
	emit_signal("new_game")
