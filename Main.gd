extends Node

onready var title := get_node("TitleScreen")
var world = null

func _ready():
	pass

func start_new_game():
	#print("start the game")
	self.call_deferred("remove_child", title)
	title.call_deferred("free") # Don't need to keep TitleScreen in memory
	world = load("res://world/GameWorld.tscn").instance()
	self.call_deferred("add_child", world)

func return_to_title():
	print("back to title")
	world = get_node("GameWorld")
	self.call_deferred("remove_child", world)
	world.call_deferred("free") # discard the game
	title = load("res://screens/title/TitleScreen.tscn").instance()
	self.call_deferred("add_child", title)