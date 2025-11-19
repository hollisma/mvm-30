extends Node3D
class_name AIComponent

var owner_enemy: BaseEnemy

func init(enemy: BaseEnemy): 
	owner_enemy = enemy

func get_steering(_delta: float) -> Vector3: 
	return Vector3.ZERO
