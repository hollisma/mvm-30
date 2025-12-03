extends Area3D
class_name StarPiece

@export var float_height := 0.2
@export var float_speed := 2.0
@export var rotate_speed := 0.5

var _base_pos: Vector3
var _time := 0.0

func _ready():
	body_entered.connect(_on_body_entered)
	_base_pos = global_position

func _on_body_entered(body: Node3D): 
	if body is Player: 
		Logr.info("Star piece collected", get_script().get_global_name())
		Events.star_piece_collected.emit()
		queue_free()

func _physics_process(delta): 
	_time += delta * float_speed
	
	var offset_y = sin(_time) * float_height
	global_position = _base_pos + Vector3.UP * offset_y
	rotate_y(delta * rotate_speed)
