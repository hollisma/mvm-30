extends Node
class_name RangedAttackComponent

signal attack_state_changed(attack_state: Enums.AttackStates)

@export var attack_data: AttackData
@export var projectile_scene: PackedScene
@export var spawn_point: Marker3D

var state: Enums.AttackStates = Enums.AttackStates.IDLE
var timer := 0.0
var cooldown_timer := 0.0
var entity_name: String
var _target: Vector3

func init(_name: String = ""):
	entity_name = _name

func request_attack_towards(target: Vector3):
	if state != Enums.AttackStates.IDLE:
		return
	if cooldown_timer > 0:
		return
	_target = target
	_start_attack()

func _start_attack():
	Logr.debug("Start attack", entity_name)
	_set_state(Enums.AttackStates.WINDUP)
	timer = attack_data.windup
	print("hi ", attack_data.windup, " ", attack_data.active_time, " ", attack_data.cooldown)

func _start_active():
	Logr.debug("Start active (spawning projectible)", entity_name)
	_set_state(Enums.AttackStates.ACTIVE)
	timer = attack_data.active_time
	_spawn_projectile()

func _start_recovery():
	Logr.debug("Start recovery", entity_name)
	_set_state(Enums.AttackStates.RECOVERY)
	timer = attack_data.cooldown
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

func _spawn_projectile():
	if projectile_scene == null:
		Logr.err("No projectile scene set for ranged attack")
		return
	
	var projectile := projectile_scene.instantiate()
	add_child(projectile)
	
	projectile.global_transform = spawn_point.global_transform
	if projectile.has_method("set_direction"):
		var dir := (_target - spawn_point.global_position).normalized()
		projectile.set_direction(dir)
	if projectile.has_method("set_damage"):
		projectile.set_damage(attack_data.damage)
