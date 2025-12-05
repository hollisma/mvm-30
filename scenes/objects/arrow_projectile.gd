extends CharacterBody3D
class_name ArrowProjectile

@export var speed: float = 15.0
@export var max_distance: float = 50.0

@onready var ray: RayCast3D = $RayCast3D

var _damage: float = 0.0
var _direction: Vector3 = Vector3.ZERO
var _origin: Vector3

func _ready():
	_origin = global_position

func set_damage(damage: float): 
	_damage = damage

func set_direction(dir: Vector3) -> void:
	dir.y = 0.0
	_direction = dir.normalized()
	look_at(global_position + _direction, Vector3.UP)

func _physics_process(_delta: float) -> void:
	if _direction == Vector3.ZERO:
		return
	
	# Move
	velocity = _direction * speed
	move_and_slide()
	
	# Raycast in front to detect hitboxes or environment
	if ray.is_colliding():
		var collider = ray.get_collider()
		print("Ray collision ", collider)
		if collider and collider.has_method("apply_damage"):
			collider.apply_damage(_damage)
		queue_free()
		return
	
	# Self-destruct if too far
	if global_position.distance_to(_origin) > max_distance:
		queue_free()
