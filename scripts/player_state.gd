extends Node

var level := 1
var experience := 0
var money := 0

func add_exp(amount): 
	experience += amount
	Events.exp_changed.emit()

func add_money(amount): 
	money += amount
	Events.money_changed.emit()
