class_name Game extends Node
# TODO class description

# Level IDs
const LEVEL1 = "warehouse1"
const LEVEL2 = "warehouse2"

const start_level_id = LEVEL1
var current_level_id = start_level_id

var levelres = {	# Where to create the levels from
	LEVEL1 : "res://world/levels/Level1.tscn",
	LEVEL2 : "res://world/levels/Level2.tscn"
}

var levels = {		# Pointers to the Level instances
	LEVEL1 : null,
	LEVEL2 : null
}

func _ready():
	create_level(start_level_id)

#func _process(delta):
#	if Input.is_action_just_pressed("1"):
#		switch_level(LEVEL1)
#	elif Input.is_action_just_pressed("2"):
#		switch_level(LEVEL2)


# This method is purely for initializing the starting level
func create_level(level_id:String) -> void:
	# Initialize the first map
	levels[level_id] = load(levelres[level_id]).instance()
	levels[level_id].z_index = -1
	current_level_id = level_id
	self.call_deferred("add_child", levels[current_level_id])
	levels[current_level_id].set_owner(self)
	
	print(level_id+" initialized")
	#p = levels[current_level].player


# This method is connected to the signal from a Portal, triggering a warp (Portal.gd)
func portal(level_id:String, portal_id:String, target_level_id:String, target_portal_id:String):
	print("WARP FROM "+level_id+"-"+portal_id+" TO "+target_level_id+"-"+target_portal_id)
	
	# Save the player and remove it from the SceneTree
	var current_level_node = levels[current_level_id] #find_node("Level*", false, true)
	print(current_level_node.name)
	var player = current_level_node.get_node("Player")
	print(player.name)
	current_level_node.call_deferred("remove_child", player) #current.remove_child(player)
	
	# Remove the current level from the SceneTree
	self.call_deferred("remove_child", current_level_node) #self.remove_child(current)
	
	# Add the new level to the SceneTree
	if levels[target_level_id] == null:
		create_level(target_level_id)
	else:
		self.call_deferred("add_child", levels[target_level_id]) #self.add_child(levels[target_level_id])
	# The new level is now the current level
	current_level_id = target_level_id
	current_level_node = levels[current_level_id]
	print(levels[current_level_id].name, " ", current_level_node.name)
	
	# Re-attach the player to the SceneTree inside the level
	current_level_node.call_deferred("add_child", player) #levels[current_level].add_child(player)
	player.set_owner(current_level_node)
	
	# Place the player at the receiving portal
	# TODO
	player.set_global_position(Vector2(64, 64))