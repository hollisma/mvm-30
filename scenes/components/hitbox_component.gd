extends Area3D
class_name HitboxComponent

var _damage: float = 1.0
var _active := false
var _entities_damaged_in_current_swing: Array[Node3D]

func _ready(): 
	body_entered.connect(_on_body_entered)

func enable(damage: float): 
	_damage = damage
	_active = true

func disable(): 
	_active = false
	_entities_damaged_in_current_swing.clear()

func _on_body_entered(body: Node3D): 
	if not _active or body in _entities_damaged_in_current_swing: 
		return
	
	_entities_damaged_in_current_swing.append(body)
	var health_component := body.get_node_or_null("HealthComponent") as HealthComponent
	if health_component: 
		health_component.apply_damage(_damage)
