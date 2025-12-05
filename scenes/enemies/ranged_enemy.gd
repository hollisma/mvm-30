extends BaseEnemy
class_name RangedEnemy

@onready var attack_component = $RangedAttackComponent

func _ready():
	entity_name = "RangedEnemy"
	max_health = 3.0
	exp_amount = 3
	money_amount = 2
	attack_component.init(entity_name)
	super._ready()

func do_attack(_attack_decision: Enums.EnemyAttackTypes): 
	attack_component.request_attack_towards(ai_component.get_target_position())
