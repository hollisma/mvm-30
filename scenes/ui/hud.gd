extends CanvasLayer

const EXP_LABEL_TEXT := "EXP: %d"
const MONEY_LABEL_TEXT := "Money: %d"
@onready var exp_label = $ExpLabel
@onready var money_label = $MoneyLabel

func _ready(): 
	Events.exp_changed.connect(_update_exp_text)
	Events.money_changed.connect(_update_money_text)
	
	_update_exp_text()
	_update_money_text()

func _update_exp_text(): 
	exp_label.text = EXP_LABEL_TEXT % PlayerState.experience

func _update_money_text(): 
	money_label.text = MONEY_LABEL_TEXT % PlayerState.money
