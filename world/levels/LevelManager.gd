class_name LevelManager extends Node2D
# This node manages the level scenes that make up the game's world.
# Levels are stored inside the `levels` dictionary when they are first instanced.
# The current level is the level that the Player is inside.
# When the player leaves, their destination level becomes the current one
# and the previous level is removed as a child of this node, 
# therefore detaching it from the SceneTree.
# This way, changes made to objects inside of a level persist when the player leaves.
# See: https://godotengine.org/qa/44664/how-can-i-move-the-player-from-one-tilemap-to-another?show=44899#c44899

# Constants used to name and identify the level keys 
const LEVEL_1 := "warehouse1"
const LEVEL_2 := "warehouse2"
const LEVEL_3 := "warehouse3"

var level_res = {	# Where to create the levels from
	LEVEL_1 : "res://world/levels/Level1.tscn",
	LEVEL_2 : "res://world/levels/Level2.tscn",
	LEVEL_3 : "res://world/levels/Level3.tscn"
}

var levels = {		# Pointers to the Level instances
	LEVEL_1 : null,
	LEVEL_2 : null,
	LEVEL_3 : null
}

# Variables to hold the keys to the levels dictionary
const START_LEVEL_KEY := LEVEL_1
var current_level_key := START_LEVEL_KEY
var grid_cell_size : Vector2

func _ready():
	create_level(START_LEVEL_KEY)

# This method is for initializing new levels
func create_level(level_key:String) -> void:
	levels[level_key] = load(level_res[level_key]).instance()
	current_level_key = level_key
	self.call_deferred("add_child", levels[current_level_key])
	#levels[current_level_key].set_owner(self)
	grid_cell_size = levels[current_level_key].get_node("Grid").get_cell_size()
	print(level_key+" initialized")

# This method is connected to the signal from a Portal, triggering a scene change (Portal.gd)
func portal(level_key:String, portal_id:String, target_level_key:String, target_portal_id:String):
	print("WARP FROM "+level_key+"-"+portal_id+" TO "+target_level_key+"-"+target_portal_id)
	
	yield(ScreenTransition.go_to_black(), "completed")
	
	# Save the player and remove it from the SceneTree
	var current_level_node = levels[current_level_key]
	var player = current_level_node.get_node("Player")
	current_level_node.call_deferred("remove_child", player)
	
	# Remove the current level from the SceneTree
	self.call_deferred("remove_child", current_level_node)
	
	# Add the new level to the SceneTree
	if levels[target_level_key] == null:
		create_level(target_level_key)
	else:
		self.call_deferred("add_child", levels[target_level_key])
	current_level_key = target_level_key # The new level is now the current level
	current_level_node = levels[current_level_key]
	
	# Re-attach the player to the SceneTree inside the level
	current_level_node.call_deferred("add_child", player)
	#player.set_owner(current_level_node)
	
	# Place the player at the receiving portal
	for object in current_level_node.get_node("Grid").get_children():
		if object is Portal:
			if object.portal_id == target_portal_id:
				object.primed = false
				player.set_position(object.get_out_direction(grid_cell_size))
				break
	
	yield(ScreenTransition.go_to_play(), "completed")