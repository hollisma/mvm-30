extends Node3D
class_name CandyCaneSword

@onready var collision_area: Area3D = $CollisionArea

var _attack_power := 2
var _entities_damaged_in_current_swing: Array[Node3D]

func _ready():
	collision_area.body_entered.connect(_on_body_entered)
	collision_area.monitoring = false

func _on_body_entered(body: Node3D): 
	if body.has_method("apply_damage") and body not in _entities_damaged_in_current_swing: 
		body.apply_damage(_attack_power)
		_entities_damaged_in_current_swing.append(body)

func start_swing(): 
	collision_area.monitoring = true

func finish_swing(): 
	collision_area.monitoring = false
	_entities_damaged_in_current_swing.clear()
