class_name GameWorld extends Node2D

onready var Main := get_node("/root/Main")
onready var BgSprite := get_node("ParallaxBackground/BlackParallaxLayer/Sprite")
signal exit_world

func _ready():
	connect("exit_world", Main, "return_to_title")
	get_tree().get_root().connect("size_changed", self, "on_window_resize")
	BgSprite.region_enabled = true
	BgSprite.set_region_rect(Rect2(0, 0, get_viewport_rect().size.x, get_viewport_rect().size.y))

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_ESCAPE:
			emit_signal("exit_world")

func on_window_resize():
	if BgSprite.region_enabled:
		BgSprite.set_region_rect(Rect2(0, 0, get_viewport_rect().size.x, get_viewport_rect().size.y))
	print("Resizing: ", BgSprite.get_region_rect())