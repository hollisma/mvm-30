extends BaseEnemy
class_name DummyEnemy

func _ready():
	entity_name = "DummyEnemy"
	max_health = 10.0
	exp_amount = 1
	money_amount = 0
	super._ready()
