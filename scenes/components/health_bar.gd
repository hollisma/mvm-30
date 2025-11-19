extends Node3D
class_name HealthBar

@onready var health_bar := $SubViewport/HealthBar

var _init := false
var _max_value: float

func init(max_health: float): 
	_max_value = max_health
	health_bar.max_value = _max_value
	health_bar.value = _max_value
	_init = true

func set_health(health: float): 
	if not _init: 
		push_warning("Health bar not initialized with max_health")
		return
	health_bar.value = health
