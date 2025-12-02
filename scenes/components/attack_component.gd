extends Node
class_name AttackComponent

signal attack_state_changed(attack_state: Enums.AttackStates)

@export var attack_data: AttackData
@export var hitbox: HitboxComponent

var state: Enums.AttackStates = Enums.AttackStates.IDLE
var timer := 0.0
var cooldown_timer := 0.0
var entity_name: String

func init(_attack_data: AttackData, _hitbox: HitboxComponent, _name: String = ""): 
	attack_data = _attack_data
	hitbox = _hitbox
	entity_name = _name

func request_attack():
	if state != Enums.AttackStates.IDLE:
		return
	if cooldown_timer > 0:
		return
	_start_attack()

func _start_attack():
	Logr.debug("Start attack", entity_name)
	_set_state(Enums.AttackStates.WINDUP)
	timer = attack_data.windup

func _start_active():
	Logr.debug("Start active", entity_name)
	_set_state(Enums.AttackStates.ACTIVE)
	timer = attack_data.active_time
	hitbox.enable(attack_data.damage)

func _start_recovery():
	Logr.debug("Start recovery", entity_name)
	_set_state(Enums.AttackStates.RECOVERY)
	timer = attack_data.cooldown
	hitbox.disable()
	cooldown_timer = attack_data.cooldown

func _finish_attack(): 
	Logr.debug("Finish attack", entity_name)
	_set_state(Enums.AttackStates.IDLE)

func _set_state(new_state: Enums.AttackStates): 
	state = new_state
	attack_state_changed.emit(state)

func _physics_process(delta):
	if cooldown_timer > 0:
		cooldown_timer -= delta
	
	match state:
		Enums.AttackStates.IDLE:
			return
		
		Enums.AttackStates.WINDUP:
			timer -= delta
			if timer <= 0:
				_start_active()
		
		Enums.AttackStates.ACTIVE:
			timer -= delta
			if timer <= 0:
				_start_recovery()
		
		Enums.AttackStates.RECOVERY:
			timer -= delta
			if timer <= 0:
				_finish_attack()
