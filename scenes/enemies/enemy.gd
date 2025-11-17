extends CharacterBody3D
class_name Enemy

@onready var damageable := $Damageable
@onready var health_bar = $HealthBar

@export var health := 5.0
@export var exp_amount := 2
@export var money_amount := 1

func _ready():
	damageable.init(health, "Enemy")
	damageable.died.connect(_do_death)
	health_bar.init(health)

func take_damage(amount: float): 
	damageable.take_damage(amount)
	health_bar.set_health(damageable.health)

func _do_death(): 
	PlayerState.add_exp(exp_amount)
	PlayerState.add_money(money_amount)
	queue_free()
