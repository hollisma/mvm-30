extends Node3D
class_name CandyCaneSword

@onready var collision_area: Area3D = $CollisionArea

var _attack_power := 10

func _ready():
	collision_area.area_entered.connect(_on_area_entered)

func _on_area_entered(body): 
	if body.is_in_group("enemy"): 
		body.take_damage(_attack_power)

func start_swing(): 
	collision_area.disable_mode = CollisionObject3D.DISABLE_MODE_KEEP_ACTIVE

func finish_swing(): 
	collision_area.disable_mode = CollisionObject3D.DISABLE_MODE_REMOVE
