extends Node3D
class_name AIComponent

var owner_enemy: BaseEnemy

func init(enemy: BaseEnemy): 
	owner_enemy = enemy

func get_steering() -> Vector3: 
	return Vector3.ZERO

func get_attack_decision() -> Enums.EnemyAttackTypes: 
	return Enums.EnemyAttackTypes.NONE

func get_target_position() -> Vector3: 
	Logr.error("AIComponent get_target_position unimplemented", owner_enemy.entity_name)
	return Vector3.ZERO
