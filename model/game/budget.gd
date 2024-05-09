extends Node
class_name Budget

var current: int = Prices.initial_budget

func can_afford(price: int) -> bool:
	return current - price >= 0

func take_from_budget(amount: int) -> void:
	current = max(current - amount, 0)
	
func add_to_budget(amount: int) -> void:
	current += amount
