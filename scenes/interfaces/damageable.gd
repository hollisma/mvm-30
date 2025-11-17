### For scenes that can take damage (e.g. enemies, destructible walls, etc)
extends Node
class_name Damageable

signal died

var max_health: float
var health: float
var entity_name: String

func init(_max_health: float, _name: String): 
	max_health = _max_health
	health = max_health
	entity_name = _name

func take_damage(amount: float): 
	health = max(health - amount, 0)
	Logr.info(entity_name, "Taking %.1f damage; At %.1f health" % [amount, health])
	if health <= 0: 
		Logr.info(entity_name, "%s died" % entity_name)
		died.emit()
