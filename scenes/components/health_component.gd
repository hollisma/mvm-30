### For scenes that can take damage (e.g. enemies, destructible walls, etc)
extends Node
class_name HealthComponent

signal damaged
signal died

var max_health: float
var current_health: float
var entity_name: String

func init(_max_health: float, _name: String): 
	max_health = _max_health
	current_health = max_health
	entity_name = _name

func apply_damage(amount: float): 
	current_health = max(current_health - amount, 0)
	damaged.emit()
	Logr.info(entity_name, "Taking %.1f damage; At %.1f health" % [amount, current_health])
	if current_health <= 0: 
		Logr.info(entity_name, "%s died" % entity_name)
		died.emit()

func is_alive() -> bool: 
	return current_health > 0
