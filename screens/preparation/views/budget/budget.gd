extends Control
class_name PreparationScreenBudget

@onready var _quantity_label: Label = %Quantity

func _process(_delta: float) -> void:
	_quantity_label.text = str(GameGlobals.budget.current)

