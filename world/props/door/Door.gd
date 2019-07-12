extends KinematicBody2D

export var door : String

func _ready():
	pass

func _process(delta):
	if Doors.id[door] == true:
		self.hide()
		$CollisionShape2D.disabled = true
	else:
		self.show()
		$CollisionShape2D.disabled = false