extends AIComponent
class_name ChaseAI

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

@export var move_speed := 4.0
@export var stop_distance := 1.7
var chase_target: Node3D
var _init := false

func init(enemy: BaseEnemy): 
	super.init(enemy)
	await get_tree().process_frame
	_init = true
	chase_target = PlayerState.player_ref

func get_steering(_delta: float) -> Vector3:
	if not _init: return Vector3.ZERO
	if not chase_target: 
		Logr.warning("No chase target", get_script().get_global_name())
		return Vector3.ZERO
	
	nav_agent.target_position = chase_target.global_position
	nav_agent.max_speed = move_speed
	
	var offset := nav_agent.get_next_path_position() - owner_enemy.global_position
	var dir = offset.normalized()
	
	var to_target = chase_target.global_position - owner_enemy.global_position
	var dist = to_target.length()
	if dist > stop_distance: 
		return dir * move_speed
	else: 
		return lerp(owner_enemy.velocity, Vector3.ZERO, 0.2)
