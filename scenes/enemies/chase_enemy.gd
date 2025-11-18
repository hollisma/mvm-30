extends BaseEnemy
class_name ChaseEnemy

func _ready():
	entity_name = "ChaseEnemy"
	max_health = 5.0
	exp_amount = 2
	money_amount = 1
	nav_agent = $NavigationAgent3D
	super._ready()
