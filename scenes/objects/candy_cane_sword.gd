extends Node3D
class_name CandyCaneSword

@onready var collision_area: Area3D = $CollisionArea

var _current_attack: Enums.CandyCaneAttacks
var _entities_damaged_in_current_swing: Array[Node3D]

func _ready():
	collision_area.body_entered.connect(_on_body_entered)
	collision_area.monitoring = false

func _on_body_entered(body: Node3D): 
	if body.has_method("apply_damage") and body not in _entities_damaged_in_current_swing: 
		body.apply_damage(_get_attack_power_for_attack(_current_attack))
		_entities_damaged_in_current_swing.append(body)

func start_swing(attack: Enums.CandyCaneAttacks): 
	collision_area.monitoring = true
	_current_attack = attack

func finish_swing(): 
	collision_area.monitoring = false
	_entities_damaged_in_current_swing.clear()

func _get_attack_power_for_attack(attack: Enums.CandyCaneAttacks) -> int: 
	match attack: 
		Enums.CandyCaneAttacks.SWING: 
			return 1
		Enums.CandyCaneAttacks.SPIN: 
			return 2
		Enums.CandyCaneAttacks.SLAM: 
			return 4
		_: 
			return 0
