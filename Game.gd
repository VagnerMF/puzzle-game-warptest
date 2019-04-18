class_name Game extends Node

# https://godotengine.org/qa/30426/how-do-i-connect-and-switch-between-mutliple-tile-maps
# http://docs.godotengine.org/en/stable/classes/class_node.html

# TODO:
# transfer the player instance from one level 
# 		to another when switching levels
# add portals for the player to walk thru from level to level

# Level IDs
const LEVEL1 = "warehouse1"
const LEVEL2 = "warehouse2"

var levelres = {	# Where to create the levels from
	LEVEL1 : "res://world/levels/Level1.tscn",
	LEVEL2 : "res://world/levels/Level2.tscn"
}

var levels = {		# Pointers to the Level instances
	LEVEL1 : null,
	LEVEL2 : null
}

var current_level = null # Refers to a Level ID
var p = null			 # Player instance

func _ready():
	start_map(LEVEL1)
	
func start_map(level_id:String) -> void:
	# Initialize the first map
	levels[level_id] = load(levelres[level_id]).instance()
	levels[level_id].z_index = -1
	current_level = level_id
	add_child(levels[current_level])
	print("Start map initialized")
	p = levels[current_level].player

func switch_map(new_level_id:String) -> void:
	
	if current_level != null and levels[current_level] != null:
		# Save and remove player
		if levels[current_level].player != null:
			remove_child(levels[current_level].player)
		else:
			#print("Can't remove player, it's NULL")
			pass
		# Remove current level from tree
		remove_child(levels[current_level])
	else:
		#print("Cant remove current level, NULL")
		pass
	
	# Switch to the new level if it has been created, or create it.
	if levels[new_level_id]==null:
		# Level has not been spawned, so create it.
		print("New level "+str(new_level_id)+" created")
		levels[new_level_id] = load(levelres[new_level_id]).instance()
		levels[new_level_id].z_index = -1
	
	# Update the current level
	current_level = new_level_id
	# Add the new current level to the tree
	add_child(levels[current_level])

	# Re-add the player to the new map
	if p!=null:
		levels[current_level].add_child(p)
		levels[current_level].player = p
	else:
		#print("p is null; no player to add!")
		pass
	#print(levels[current_level].player)

func warp_to_map(new_level_id:String, target_portal_id:String) -> void:
	
	if current_level != null and levels[current_level] != null:
		# Save and remove player
		if levels[current_level].player != null:
			remove_child(levels[current_level].player)
		else:
			#print("Can't remove player, it's NULL")
			pass
		# Remove current level from tree
		remove_child(levels[current_level])
	else:
		#print("Cant remove current level, NULL")
		pass
	
	# Switch to the new level if it has been created, or create it.
	if levels[new_level_id]==null:
		# Level has not been spawned, so create it.
		print("NEW LEVEL "+str(new_level_id)+" created")
		levels[new_level_id] = load(levelres[new_level_id]).instance()
		levels[new_level_id].z_index = -1
	
	# Update the current level
	current_level = new_level_id
	# Add the new current level to the tree
	add_child(levels[current_level])

	# Re-add the player to the new map
	if p!=null:
		levels[current_level].call_deferred('add_child', p)
		#levels[current_level].add_child(p)
		levels[current_level].player = p
		# ****************** BROKEN! ****************************************
		# Can't seem to get the player to display on the new level
		# Find the target portal and set the player's coords to it
		#var grid = levels[current_level].get_node("Grid")
		# ** TODO: there must be a better way to directly access the portal...
		#for N in grid.get_children():
		#	if N is Portal:
		#		if N.portal_id==target_portal_id:
		#			# Found it!
		#			levels[current_level].player.set_position(N.get_position())
		levels[current_level].player.set_position(Vector2(192, 192))
		print(p.name)
	else:
		print("p is null; no player to add!")
	

func portal(level_id:String, portal_id:String, target_level_id:String, target_portal_id:String):
	print("WARP FROM "+level_id+", "+portal_id+" TO "+target_level_id+", "+target_portal_id)
	warp_to_map(target_level_id, target_portal_id)

func _process(delta):
	if Input.is_action_just_pressed("1"):
		switch_map(LEVEL1)
	elif Input.is_action_just_pressed("2"):
		switch_map(LEVEL2)