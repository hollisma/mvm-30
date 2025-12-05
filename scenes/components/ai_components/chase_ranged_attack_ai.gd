extends AIComponent
class_name ChaseRangedAttackAI

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

@export var move_speed := 3.0
@export var stop_range := Vector2(10, 15)
var chase_target: Node3D
var _init := false

func init(enemy: BaseEnemy): 
	super.init(enemy)
	await get_tree().process_frame
	_init = true
	chase_target = PlayerState.player_ref
	nav_agent.max_speed = move_speed

# Aim to be within the stop_range distance from target
func get_steering() -> Vector3:
	if not _init: return Vector3.ZERO
	if not chase_target: 
		Logr.warning("No chase target", get_script().get_global_name())
		return Vector3.ZERO
	
	var dist_to_target := _get_distance_to_target()
	# Move towards
	if dist_to_target > stop_range.y: 
		nav_agent.target_position = chase_target.global_position
		var offset := nav_agent.get_next_path_position() - owner_enemy.global_position
		var dir := offset.normalized()
		return dir * move_speed
	# Move away
	elif dist_to_target < stop_range.x: 
		var to_target := chase_target.global_position - owner_enemy.global_position
		var dir_to_target := to_target.normalized()
		var move_target_delta := dir_to_target * stop_range.x
		var dest := chase_target.global_position - move_target_delta
		dest.y = 0.0
		var offset := dest - owner_enemy.global_position
		var dir = offset.normalized()
		return dir * move_speed
	# Come to a stop
	else: 
		return lerp(owner_enemy.velocity, Vector3.ZERO, 0.2)

# Return RANGED attack if within stop_range end
func get_attack_decision() -> Enums.EnemyAttackTypes:
	if not _init: return Enums.EnemyAttackTypes.NONE
	if not chase_target: 
		Logr.warning("No chase target", get_script().get_global_name())
		return Enums.EnemyAttackTypes.NONE
	
	var dist := _get_distance_to_target()
	if dist < stop_range.y: 
		return Enums.EnemyAttackTypes.RANGED
	return Enums.EnemyAttackTypes.NONE

func get_target_position() -> Vector3: 
	return chase_target.global_position

func _get_distance_to_target() -> float: 
	var to_target = chase_target.global_position - owner_enemy.global_position
	return to_target.length()
