extends Resource
class_name AttackData

@export var attack_name: String
@export var damage: float
@export var windup: float
@export var active_time: float
@export var cooldown: float

func _init(a_name := "", d := 1.0, w := 0.25, a := 0.2, c := 0.8): 
	attack_name = a_name
	damage = d
	windup = w
	active_time = a
	cooldown = c
