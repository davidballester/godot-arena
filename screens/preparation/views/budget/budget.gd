extends Control
class_name PreparationScreenBudget

@onready var _quantity_label: Label = %Quantity
	
func set_budget(budget: int) -> void:
	_quantity_label.text = str(budget)
