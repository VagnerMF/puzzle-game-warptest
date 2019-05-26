class_name Portal extends Area2D

# When a player enters a portal, they should be transported to a connected portal
# on a different level. See Game.gd

enum DIRECTION { # The direction the player exits the portal to
	NONE,
	EAST,
	NORTH,
	WEST,
	SOUTH
}

export var level_id : String
export var portal_id : String
export var target_level_id : String
export var target_portal_id : String
export (DIRECTION) var out_direction = DIRECTION.NONE

#onready var LevelManager = get_node("/root/Main/GameWorld/LevelManager")
onready var LevelManager = find_parent("LevelManager")
var primed = true # Whether or not the Portal can be triggered

signal player_entered
signal player_exited

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	connect("player_entered", LevelManager, "portal")
	
func _on_body_entered(body: PhysicsBody2D) -> void:
	if not body is Player:
		return
	if primed:
		emit_signal("player_entered", level_id, portal_id, target_level_id, target_portal_id)

func _on_body_exited(body: PhysicsBody2D) -> void:
	if not body is Player:
		return
	primed = true
	emit_signal("player_exited")

func get_out_direction(cell_size: Vector2) -> Vector2:
	# TODO spawn player in center of tile or at edges?
	return Vector2(get_position().x + cell_size.x/2, get_position().y + cell_size.y/2)
#	match out_direction:
#		DIRECTION.EAST:
#			return Vector2(get_position().x + cell_size.x, get_position().y + cell_size.y/2)
#		DIRECTION.NORTH:
#			return Vector2(get_position().x + cell_size.x/2, get_position().y)
#		DIRECTION.WEST:
#			return Vector2(get_position().x, get_position().y + cell_size.y/2)
#		DIRECTION.SOUTH:
#			return Vector2(get_position().x + cell_size.x/2, get_position().y)
#		_: # default
#			return get_position()