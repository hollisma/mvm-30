extends BaseEnemy
class_name SwordEnemy

@onready var attack_component = $AttackComponent
@onready var sword_hitbox = $RightHand/Sword/HitboxComponent
@onready var animation_player = $AnimationPlayer

func _ready():
	entity_name = "SwordEnemy"
	max_health = 5.0
	exp_amount = 2
	money_amount = 1
	super._ready()
	
	var attack_data: AttackData = load("res://scenes/enemies/sword_enemy_attack.tres")
	attack_component.init(attack_data, sword_hitbox, entity_name)
	attack_component.attack_state_changed.connect(_on_attack_state_changed)

func do_attack(_attack_decision: Enums.EnemyAttackTypes): 
	attack_component.request_attack()

func _on_attack_state_changed(attack_state: Enums.AttackStates): 
	match attack_state: 
		Enums.AttackStates.WINDUP: 
			animation_player.play("windup")
		Enums.AttackStates.ACTIVE: 
			animation_player.play("active")
		Enums.AttackStates.RECOVERY: 
			animation_player.play("recovery")
