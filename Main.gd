extends Node

onready var title := get_node("TitleScreen")
var world = null


func _ready():
	pass


func start_new_game():
	yield(ScreenTransition.go_to_black(), "completed")
	
	self.call_deferred("remove_child", title)
	title.call_deferred("free") # Don't need to keep TitleScreen in memory
	world = load("res://world/GameWorld.tscn").instance()
	self.call_deferred("add_child", world)
	
	yield(ScreenTransition.go_to_play(), "completed")


func return_to_title():
	yield(ScreenTransition.go_to_black(), "completed")
	
	world = get_node("GameWorld")
	self.call_deferred("remove_child", world)
	world.call_deferred("free") # discard the game
	title = load("res://screens/title/TitleScreen.tscn").instance()
	self.call_deferred("add_child", title)
	
	yield(ScreenTransition.go_to_play(), "completed")