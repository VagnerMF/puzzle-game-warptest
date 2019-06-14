class_name Player extends KinematicBody2D


onready var animated_sprite : AnimatedSprite = $AnimatedSprite
onready var spr_w = $AnimatedSprite.frames.get_frame($AnimatedSprite.animation, $AnimatedSprite.frame).get_size().x
onready var spr_h = $AnimatedSprite.frames.get_frame($AnimatedSprite.animation, $AnimatedSprite.frame).get_size().y
export var move_speed : = 250.0
export var push_speed : = 125.0
var motion : = Vector2()
var direction : String = "down"
# Push timer: https://www.reddit.com/r/godot/comments/8p3lm0/fps_counter_in_game/
const PUSH_TIME := 0.35
var push_timer := 0.0


func _ready():
	print("Player anim texture: %dx%d" % [spr_w, spr_h])


func _physics_process(delta: float) -> void:
	motion.x = int(Input.get_action_strength("move_right")) - int(Input.get_action_strength("move_left"))
	motion.y = int(Input.get_action_strength("move_down")) - int(Input.get_action_strength("move_up"))
	# Determine direction based on motion
	if motion.x > 0:
		direction = "right"
	elif motion.x < 0:
		direction = "left"
	elif motion.y < 0:
		direction = "up"
	elif motion.y > 0:
		direction = "down"
	update_animation(motion)
	move_and_slide(
		motion.normalized() * move_speed, 
		Vector2()
	)
	if get_slide_count() > 0:
		if get_slide_collision(0).collider is Box:
			check_box_collision(delta, motion)
	else:
		push_timer = 0.0
	
	# Set target looking vector based on which direction Player is facing
	var looking_at : Vector2
	if direction == "down":
		looking_at = Vector2(self.position.x, self.position.y + spr_h/2)
	elif direction == "up":
		looking_at = Vector2(self.position.x, self.position.y - spr_h/2)
	elif direction == "left":
		looking_at = Vector2(self.position.x - spr_w/2, self.position.y)
	elif direction == "right":
		looking_at = Vector2(self.position.x + spr_w/2, self.position.y)
		
	# Detect something to interact with (eg. Talker) at the target looking location
	if Input.is_action_just_pressed("ui_accept"):
		#print("self: %d, %d\tray: %d, %d" % [self.position.x, self.position.y, looking_at.x, looking_at.y])
		var shapes := get_world_2d().direct_space_state.intersect_point(looking_at)
		#print(shapes)
		for shape in shapes:
			#print(shape.collider.name)
			if shape.collider is Talker:
				print("Speak!")
				shape.collider.speak()


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


func update_animation(motion: Vector2) -> void:
	if motion.x==0 and motion.y==0:
		animated_sprite.stop()
	elif animated_sprite.animation != direction:
		animated_sprite.play(direction)