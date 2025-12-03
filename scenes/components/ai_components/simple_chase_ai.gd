extends AIComponent
class_name SimpleChaseAI

@export var move_speed := 4.0
@export var stop_distance := 1.5
var chase_target: Node3D
var _init := false

func init(enemy: BaseEnemy): 
	super.init(enemy)
	await get_tree().process_frame
	_init = true
	chase_target = PlayerState.player_ref

func get_steering() -> Vector3:
	if not _init: return Vector3.ZERO
	if not chase_target: 
		Logr.warning("No chase target", get_script().get_global_name())
		return Vector3.ZERO
	
	var to_target = chase_target.global_transform.origin - owner_enemy.global_transform.origin
	to_target.y = 0.0
	var dist = to_target.length()
	
	if dist > stop_distance: 
		return to_target.normalized() * move_speed
	else: 
		return lerp(owner_enemy.velocity, Vector3.ZERO, 0.2)
