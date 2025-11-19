extends Node3D
class_name CandyCaneSword

@onready var hitbox_component: HitboxComponent = $HitboxComponent

func _ready():
	hitbox_component.disable()

func start_attack(attack: Enums.CandyCaneAttacks): 
	var attack_power := _get_attack_power_for_attack(attack)
	hitbox_component.enable(attack_power)

func finish_attack(): 
	hitbox_component.disable()

func _get_attack_power_for_attack(attack: Enums.CandyCaneAttacks) -> int: 
	match attack: 
		Enums.CandyCaneAttacks.SWING: 
			return 1
		Enums.CandyCaneAttacks.SPIN: 
			return 2
		Enums.CandyCaneAttacks.SLAM: 
			return 4
		_: 
			return 0
