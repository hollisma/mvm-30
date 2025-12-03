extends Node
const TAG = "PlayerState"

var player_ref: Player
var level := 1
var experience := 0
var money := 0
var health := 0.0

func add_exp(amount: int): 
	experience += amount
	Logr.info(TAG, "Gained %d EXP; At %d" % [amount, experience])
	_check_level_up()
	Events.exp_changed.emit()

func add_money(amount: int): 
	money += amount
	Logr.info(TAG, "Gained %d money; At %d" % [amount, money])
	Events.money_changed.emit()

func set_health(amount: float): 
	Logr.info(TAG, "Player health at %d" % amount)
	health = amount
	Events.health_changed.emit()

func _check_level_up(): 
	var exp_for_next_level = _exp_for_level(level)
	if experience >= exp_for_next_level: 
		experience -= exp_for_next_level
		level += 1
		Events.level_changed.emit()
		Logr.info(TAG, "Leveled up to %d" % level)

func _exp_for_level(_level: int): 
	return _level * 5
