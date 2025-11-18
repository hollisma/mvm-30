extends BaseEnemy
class_name SimpleChaseEnemy

func _ready():
	entity_name = "SimpleChaseEnemy"
	max_health = 5.0
	exp_amount = 2
	money_amount = 1
	super._ready()
