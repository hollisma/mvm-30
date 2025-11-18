extends Node3D

@onready var player = $Player

func _ready():
	Logr.min_level = Logr.Level.DEBUG
	PlayerState.player_ref = player
