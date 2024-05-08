extends Control
class_name BattleScreenBudget

@onready var _quantity: Label = %Quantity

func _process(_delta: float) -> void:
	_quantity.text = str(GameGlobals.budget.current)
