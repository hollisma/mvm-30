extends CharacterBody3D
class_name BaseEnemy

@onready var health_component: HealthComponent = $HealthComponent
@onready var ai_component: AIComponent = $AIComponent
@onready var nav_agent: NavigationAgent3D

@export var entity_name := "BaseEnemy"
@export var max_health := 1.0
@export var exp_amount := 0
@export var money_amount := 0

func _ready():
	if health_component: 
		health_component.died.connect(_on_died)
		health_component.init(max_health, entity_name)
	else: 
		Logr.warning("No health component for %s" % self, entity_name)
	
	if ai_component: 
		ai_component.init(self)
	else: 
		Logr.warning("No AI component for %s" % self, entity_name)

func _physics_process(delta): 
	if ai_component and health_component and health_component.is_alive(): 
		var steer = ai_component.get_steering(delta)
		velocity.x = steer.x
		velocity.z = steer.z
		move_and_slide()

func apply_damage(amount: float): 
	if health_component: health_component.apply_damage(amount)

func set_health_bar(toggle: bool): 
	health_component.set_health_bar(toggle)

func _on_died(): 
	PlayerState.add_exp(exp_amount)
	PlayerState.add_money(money_amount)
	queue_free()
