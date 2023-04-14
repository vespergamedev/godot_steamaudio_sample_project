extends CharacterBody3D
 
@onready var head = $Head
@export var speed: int = 10
@export var gravity: float = 30.0
@export var jump: int = 10
@export var mouse_sensitivity: float = 0.05
@export var acceleration: int = 8
@export var deacceleration: int = 10

const FLOOR_MAX_ANGLE: float = deg_to_rad(46.0)

var vel3d = Vector3.ZERO
var direction = Vector3.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x*mouse_sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y*mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x,deg_to_rad(-90),deg_to_rad(90))

func movement(delta):

	var grounded : bool = is_on_floor()
	var snap : Vector3 = Vector3.ZERO

	if grounded:
		direction = Vector3.ZERO	
		if (Input.is_action_pressed("move_fwd")):
			direction -= transform.basis.z
		elif (Input.is_action_pressed("move_bwd")):
			direction += transform.basis.z
		if (Input.is_action_pressed("move_left")):
			direction -= transform.basis.x
		elif (Input.is_action_pressed("move_right")):
			direction += transform.basis.x
			

		direction = direction.normalized()
	
	if grounded:
		snap = Vector3.DOWN
		vel3d.y = 0
		if Input.is_action_just_pressed("action_jump"):
			snap = Vector3.ZERO
			vel3d.y = jump
		
			
	vel3d.y -= gravity * delta

	var _temp_vel: Vector3 = vel3d
	_temp_vel.y = 0
	var _target: Vector3 = direction * speed
	var _temp_accel: float
	if direction.dot(_temp_vel) > 0:
		_temp_accel = acceleration
	else:
		_temp_accel = deacceleration	

	_temp_vel = _temp_vel.lerp(_target, _temp_accel * delta)
	vel3d.x = _temp_vel.x
	vel3d.z = _temp_vel.z

	if direction.dot(vel3d) == 0:
		var _vel_clamp := 0.25
		if abs(vel3d.x) < _vel_clamp:
			vel3d.x = 0
		if abs(vel3d.z) < _vel_clamp:
			vel3d.z = 0


	set_velocity(vel3d)
	set_up_direction(Vector3.UP)
	move_and_slide()
	var moving = vel3d
	if is_on_wall():
		vel3d = moving
	else:
		vel3d.y = moving.y
		
func _physics_process(delta):	
	movement(delta)

	
