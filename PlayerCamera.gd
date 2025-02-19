extends Node3D

@export var sensitivity: float = 0.1
var rotation_x = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotation_x -= event.relative.y * sensitivity
		rotation_x = clamp(rotation_x, -90, 90)
		rotation_degrees.x = rotation_x
		get_parent().rotate_y(deg_to_rad(-event.relative.x * sensitivity))
