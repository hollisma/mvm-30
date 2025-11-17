extends CanvasLayer

const LEVEL_LABEL_TEXT := "Level: %d"
const EXP_LABEL_TEXT := "EXP: %d"
const MONEY_LABEL_TEXT := "Money: %d"

@onready var level_label = $LevelLabel
@onready var exp_label = $ExpLabel
@onready var money_label = $MoneyLabel

func _ready(): 
	Events.level_changed.connect(_update_level_text)
	Events.exp_changed.connect(_update_exp_text)
	Events.money_changed.connect(_update_money_text)
	
	_update_level_text()
	_update_exp_text()
	_update_money_text()

func _update_level_text(): 
	level_label.text = LEVEL_LABEL_TEXT % PlayerState.level

func _update_exp_text(): 
	exp_label.text = EXP_LABEL_TEXT % PlayerState.experience

func _update_money_text(): 
	money_label.text = MONEY_LABEL_TEXT % PlayerState.money
