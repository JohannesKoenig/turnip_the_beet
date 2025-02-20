class_name MoneyUi extends Control

@onready var label = $HBoxContainer/Label

var money: Money
# Called when the node enters the scene tree for the first time.
func _ready():
	money = Model.money
	money.count_changed.connect(_on_money_changed)
	_on_money_changed(money.count, 0)



func _on_money_changed(new_value: int, delta: int):
	label.text = str(new_value)
