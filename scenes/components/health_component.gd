### For scenes that can take damage (e.g. enemies, destructible walls, etc)
extends Node3D
class_name HealthComponent

signal damaged
signal died

@onready var health_bar: HealthBar = $HealthBar
var max_health: float
var current_health: float
var entity_name: String

func init(_max_health: float, _name: String, show_health_bar := true): 
	max_health = _max_health
	current_health = max_health
	entity_name = _name
	
	health_bar.visible = show_health_bar
	health_bar.init(max_health)
	_update_health_bar()

func apply_damage(amount: float): 
	current_health = max(current_health - amount, 0)
	damaged.emit()
	_update_health_bar()
	Logr.info(entity_name, "Taking %.1f damage; At %.1f health" % [amount, current_health])
	
	if current_health <= 0: 
		Logr.info(entity_name, "%s died" % entity_name)
		died.emit()

func is_alive() -> bool: 
	return current_health > 0

func set_health_bar(toggle: bool): 
	health_bar.visible = toggle

func _update_health_bar(): 
	if health_bar: 
		health_bar.set_health(current_health)
