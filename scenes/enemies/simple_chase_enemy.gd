extends BaseEnemy
class_name SimpleChaseEnemy

@export var move_speed := 4.0
var chase_target: Node3D

func _ready():
	entity_name = "SimpleChaseEnemy"
	max_health = 5.0
	exp_amount = 2
	money_amount = 1
	super._ready()
	
	await get_tree().process_frame
	chase_target = PlayerState.player_ref

func _physics_process(_delta: float) -> void:
	if chase_target and health.is_alive():
		var dir = (chase_target.global_transform.origin - global_transform.origin).normalized()
		velocity.x = dir.x * move_speed
		velocity.z = dir.z * move_speed
		move_and_slide()
