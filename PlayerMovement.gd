extends CharacterBody3D

@export var speed: float = 5.0
@export var jump_strength: float = 4.0
@export var gravity: float = 9.8

@onready var camera = $PlayerCamera

func _ready():
	var key_w = InputEventKey.new()
	key_w.keycode = KEY_W
	InputMap.action_add_event("ui_up", key_w)

	var key_s = InputEventKey.new()
	key_s.keycode = KEY_S
	InputMap.action_add_event("ui_down", key_s)

	var key_a = InputEventKey.new()
	key_a.keycode = KEY_A
	InputMap.action_add_event("ui_left", key_a)

	var key_d = InputEventKey.new()
	key_d.keycode = KEY_D
	InputMap.action_add_event("ui_right", key_d)

func _physics_process(delta):
	var input_dir = Vector3.ZERO

	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dir.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	var forward = camera.global_transform.basis.z
	var right = camera.global_transform.basis.x

	var move_direction = (right * input_dir.x + forward * input_dir.z).normalized()

	velocity.x = move_direction.x * speed
	velocity.z = move_direction.z * speed

	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_strength

	move_and_slide()
