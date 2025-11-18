extends CharacterBody3D
class_name BaseEnemy

@onready var health := $Health
@onready var health_bar = $HealthBar

@export var entity_name := "BaseEnemy"
@export var max_health := 5.0
@export var exp_amount := 1
@export var money_amount := 1

func _ready():
	if health: 
		health.died.connect(_on_died)
		health.damaged.connect(_on_damaged)
		health.init(max_health, entity_name)
	else: 
		Logr.warning("No health component for %s" % self, entity_name)
	
	if health_bar: 
		health_bar.init(max_health)
	else: 
		Logr.warning("No health bar for %s" % self, entity_name)

func apply_damage(amount: float): 
	if health: health.apply_damage(amount)

func _on_damaged(): 
	if health_bar: health_bar.set_health(health.current_health)

func _on_died(): 
	PlayerState.add_exp(exp_amount)
	PlayerState.add_money(money_amount)
	queue_free()
