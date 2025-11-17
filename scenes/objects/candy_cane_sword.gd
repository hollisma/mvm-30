extends Node3D
class_name CandyCaneSword

@onready var collision_area: Area3D = $CollisionArea

var _attack_power := 2

func _ready():
	collision_area.body_entered.connect(_on_body_entered)
	collision_area.monitoring = false

func _on_body_entered(body): 
	if body.has_method("take_damage"): 
		body.take_damage(_attack_power)

func start_swing(): 
	collision_area.monitoring = true

func finish_swing(): 
	collision_area.monitoring = false
