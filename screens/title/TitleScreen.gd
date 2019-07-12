class_name TitleScreen extends Control

onready var Main := get_node("/root/Main")
signal new_game

func _ready():
	connect("new_game", Main, "start_new_game")

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER or event.scancode == KEY_SPACE:
			emit_signal("new_game")

func _on_StartButton_pressed():
	emit_signal("new_game")