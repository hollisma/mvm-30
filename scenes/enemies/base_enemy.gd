extends CharacterBody3D
class_name BaseEnemy
### HealthComponent and AIComponent are required

@onready var health_component: HealthComponent
@onready var ai_component: AIComponent

@export var entity_name := "BaseEnemy"
@export var max_health := 1.0
@export var exp_amount := 0
@export var money_amount := 0

func _ready():
	for child in get_children(): 
		if child is HealthComponent: 
			health_component = child
		if child is AIComponent: 
			ai_component = child
	if health_component == null: Logr.error("No health component for %s" % self, entity_name)
	if ai_component == null: Logr.error("No AI component for %s" % self, entity_name)
	
	health_component.died.connect(_on_died)
	health_component.init(max_health, entity_name)
	ai_component.init(self)

func _physics_process(_delta): 
	if not health_component.is_alive(): 
		return
	
	velocity = ai_component.get_steering()
	move_and_slide()
	
	if ai_component.get_attack_decision(): 
		print("Enemy attacking")
		pass # attack_component.attack()

func apply_damage(amount: float): 
	if health_component: health_component.apply_damage(amount)

func set_health_bar(toggle: bool): 
	health_component.set_health_bar(toggle)

func _on_died(): 
	PlayerState.add_exp(exp_amount)
	PlayerState.add_money(money_amount)
	queue_free()
