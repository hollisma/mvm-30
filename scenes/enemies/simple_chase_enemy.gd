extends BaseEnemy
class_name SimpleChaseEnemy

@export var move_speed := 4.0
@export var stop_distance := 3.5
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
	if not chase_target or not health.is_alive(): 
		return
	
	var to_player = chase_target.global_transform.origin - global_transform.origin
	var dist = to_player.length()
	
	if dist > stop_distance: 
		var dir = to_player.normalized()
		velocity.x = dir.x * move_speed
		velocity.z = dir.z * move_speed
	else: 
		velocity.x = lerp(velocity.x, 0.0, 0.2)
		velocity.z = lerp(velocity.z, 0.0, 0.2)
	move_and_slide()
