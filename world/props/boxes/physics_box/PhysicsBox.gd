class_name PhysicsBox extends Box


func push(velocity: Vector2) -> void:
	move_and_slide(velocity, Vector2())
