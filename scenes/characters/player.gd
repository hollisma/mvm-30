extends CharacterBody3D
class_name Player

@export_group("Speeds")
@export var look_speed: float = 0.002
@export var base_speed: float = 7.0
@export var jump_velocity: float = 5.0
@export var sprint_speed: float = 10.0
@export var freefly_speed: float = 25.0

@onready var head: Node3D = $Head
@onready var collider: CollisionShape3D = $Collider

var _move_speed := 0.0
var _look_rotation: Vector2
var _mouse_captured := false
var _freeflying := false

func _ready():
	_look_rotation.y = rotation.y
	_look_rotation.x = head.rotation.x

func _unhandled_input(event: InputEvent):
	# Mouse capturing
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		capture_mouse()
	if Input.is_key_pressed(KEY_ESCAPE):
		release_mouse()
	
	# Look around
	if _mouse_captured and event is InputEventMouseMotion:
		rotate_gaze(event.relative)
	
	# Toggle freefly mode
	if Input.is_action_just_pressed("dev_freefly"):
		if not _freeflying:
			enable_freefly()
		else:
			disable_freefly()

################
### MOVEMENT ###
################

func _physics_process(delta: float):
	if _freeflying:
		_do_freefly_move(delta)
		return
	
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Sprint
	if Input.is_action_pressed("sprint"):
		_move_speed = sprint_speed
	else:
		_move_speed = base_speed

	# Set velocity based on inputs
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var move_dir := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if move_dir:
		velocity.x = move_dir.x * _move_speed
		velocity.z = move_dir.z * _move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, _move_speed)
		velocity.z = move_toward(velocity.z, 0, _move_speed)
	
	move_and_slide()

func _do_freefly_move(delta: float): 
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var motion_dir := (head.global_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var motion := motion_dir * freefly_speed * delta
	move_and_collide(motion)

#############
### MOUSE ###
#############

func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	_mouse_captured = true

func release_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	_mouse_captured = false

func rotate_gaze(rot_input: Vector2):
	_look_rotation.x -= rot_input.y * look_speed
	_look_rotation.x = clamp(_look_rotation.x, deg_to_rad(-85), deg_to_rad(85))
	_look_rotation.y -= rot_input.x * look_speed
	transform.basis = Basis()
	rotate_y(_look_rotation.y) # Rotate entire player left / right
	head.transform.basis = Basis() # Reset basis (rot + scale)
	head.rotate_x(_look_rotation.x) # Rotate only head up / down

#############
### OTHER ###
#############

func enable_freefly():
	collider.disabled = true
	_freeflying = true
	velocity = Vector3.ZERO

func disable_freefly():
	collider.disabled = false
	_freeflying = false
