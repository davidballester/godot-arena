extends Node
class_name MinMax

@export var max_value: int = 10
@export var min_value: int = 0

func get_random_value() -> int:
	return randi_range(min_value, max_value)
