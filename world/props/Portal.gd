class_name Portal extends Area2D

# When a player enters a portal, they should be transported to a connected portal
# on a different level. See Game.gd

# https://www.reddit.com/r/godot/comments/9wqhd0/signals_with_arguments/

export var level_id : String
export var portal_id : String
export var target_level_id: String
export var target_portal_id: String

onready var main = get_node("/root/Game")

signal player_entered
signal player_exited

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	
	connect("player_entered", main, "portal")
	
func _on_body_entered(body: PhysicsBody2D) -> void:
	if not body is Player:
		return
	emit_signal("player_entered", level_id, portal_id, target_level_id, target_portal_id)

func _on_body_exited(body: PhysicsBody2D) -> void:
	if not body is Player:
		return
	emit_signal("player_exited")

