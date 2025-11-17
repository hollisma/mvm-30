extends CharacterBody3D
class_name Enemy
@onready var damageable := $Damageable

@export var health := 25.0

func _ready():
	damageable.init(health, "Enemy")
	damageable.died.connect(_do_death)

func take_damage(amount: float): 
	damageable.take_damage(amount)

func _do_death(): 
	queue_free()
	# Do experience / money
