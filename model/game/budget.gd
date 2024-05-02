extends Node
class_name Budget

const INITIAL_BUDGET = 10

var current: int = INITIAL_BUDGET

func can_afford(price: int) -> bool:
	return current - price >= 0

func take_from_budget(amount: int) -> void:
	current = max(current - amount, 0)
	
func add_to_budget(amount: int) -> void:
	current += amount
