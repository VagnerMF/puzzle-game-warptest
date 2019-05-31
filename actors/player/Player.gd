class_name Player extends KinematicBody2D

onready var animated_sprite : AnimatedSprite = $AnimatedSprite

export var move_speed : = 250.0
export var push_speed : = 125.0

var motion : = Vector2()

# Make the player put some effort into pushing
# https://www.reddit.com/r/godot/comments/8p3lm0/fps_counter_in_game/
const PUSH_TIME := 0.35
var push_timer := 0.0

func _physics_process(delta: float) -> void:

	motion.x = int(Input.get_action_strength("move_right")) - int(Input.get_action_strength("move_left"))
	motion.y = int(Input.get_action_strength("move_down")) - int(Input.get_action_strength("move_up"))
	
	update_animation(motion)
	move_and_slide(motion.normalized() * move_speed, Vector2())
	if get_slide_count() > 0:
		
		if get_slide_collision(0).collider is Box:
			check_box_collision(delta, motion)
		elif get_slide_collision(0).collider is Talker:
			check_talker_collision(delta, motion)
	
	else:
		push_timer = 0.0


func check_box_collision(delta:float, motion: Vector2) -> void:
	if abs(motion.x) + abs(motion.y) > 1:
		# Ensures we can't push diagonally
		return
	var box : = get_slide_collision(0).collider as Box
	if box:
		push_timer += delta
		if push_timer > PUSH_TIME:
			box.push(push_speed * motion)
	else:
		push_timer = 0.0


func check_talker_collision(delta:float, motion:Vector2) -> void:
	if abs(motion.x) + abs(motion.y) > 1:
		return
	var talker : = get_slide_collision(0).collider as Talker
	if talker and Input.is_action_just_pressed("ui_accept"):
		# Speak, Horatio!
		print("Speak!")
		talker.speak()


func update_animation(motion: Vector2) -> void:
	var animation : = "idle"
	
	if motion.x > 0:
		animation = "right"
	elif motion.x < 0:
		animation = "left"
	elif motion.y < 0:
		animation = "up"
	elif motion.y > 0:
		animation = "down"
	
	if animated_sprite.animation != animation:
		animated_sprite.play(animation)