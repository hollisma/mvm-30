extends Node

var level := 1
var experience := 0
var money := 0

func add_exp(amount): 
	experience += amount
	_check_level_up()
	Events.exp_changed.emit()

func add_money(amount): 
	money += amount
	Events.money_changed.emit()

func _check_level_up(): 
	var exp_for_next_level = _exp_for_level(level)
	if experience >= exp_for_next_level: 
		experience -= exp_for_next_level
		level += 1
		Events.level_changed.emit()
		print("[DEBUG] Leveled up to %d" % level)

func _exp_for_level(_level: int): 
	return _level * 5
