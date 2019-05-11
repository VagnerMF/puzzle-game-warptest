class_name LevelManager extends Node
# This node manages the level scenes that make up the game's world.
# Levels are stored inside the `levels` dictionary when they are first instanced.
# The current level is the level that the Player is inside.
# When the player leaves, their destination level becomes the current one
# and the previous level is removed as a child of this node, 
# therefore detaching it from the SceneTree.
# This way, changes made to objects inside of a level persist when the player leaves.
# See: https://godotengine.org/qa/44664/how-can-i-move-the-player-from-one-tilemap-to-another?show=44899#c44899


# Constant used to name and identify the level keys 
const LEVEL1 = "warehouse1"
const LEVEL2 = "warehouse2"

var levelRes = {	# Where to create the levels from
	LEVEL1 : "res://world/levels/Level1.tscn",
	LEVEL2 : "res://world/levels/Level2.tscn"
}

var levels = {		# Pointers to the Level instances
	LEVEL1 : null,
	LEVEL2 : null
}

# Variables to hold the keys to the levels dictionary
const startLevelKey = LEVEL1
var currentLevelKey = startLevelKey

func _ready():
	create_level(startLevelKey)

# This method is for initializing new levels
func create_level(level_key:String) -> void:
	# Initialize the first map
	levels[level_key] = load(levelRes[level_key]).instance()
	currentLevelKey = level_key
	self.call_deferred("add_child", levels[currentLevelKey])
	levels[currentLevelKey].set_owner(self)
	
	print(level_key+" initialized")

# This method is connected to the signal from a Portal, triggering a scene change (Portal.gd)
func portal(level_key:String, portal_id:String, target_level_key:String, target_portal_id:String):
	print("WARP FROM "+level_key+"-"+portal_id+" TO "+target_level_key+"-"+target_portal_id)
	
	# Save the player and remove it from the SceneTree
	var current_level_node = levels[currentLevelKey]
	var player = current_level_node.get_node("Player")
	current_level_node.call_deferred("remove_child", player)
	
	# Remove the current level from the SceneTree
	self.call_deferred("remove_child", current_level_node)
	
	# Add the new level to the SceneTree
	if levels[target_level_key] == null:
		create_level(target_level_key)
	else:
		self.call_deferred("add_child", levels[target_level_key])
	currentLevelKey = target_level_key # The new level is now the current level
	current_level_node = levels[currentLevelKey]
	
	# Re-attach the player to the SceneTree inside the level
	current_level_node.call_deferred("add_child", player)
	player.set_owner(current_level_node)
	
	# Place the player at the receiving portal
	# TODO
	player.set_position(Vector2(64, 64))