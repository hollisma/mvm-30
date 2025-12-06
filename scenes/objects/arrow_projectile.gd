extends CharacterBody3D
class_name ArrowProjectile

@export var speed: float = 15.0
@export var max_distance: float = 50.0

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
	
	# Collision detection
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if not collider:
			continue
		Logr.info("Arrow hit: %s" % collider, get_script().get_global_name())
		if collider.has_method("apply_damage"):
			collider.apply_damage(_damage)
		queue_free()
		return
	
	# Self-destruct if too far
	if global_position.distance_to(_origin) > max_distance:
		queue_free()
