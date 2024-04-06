extends Node
class_name MinMax

static func create(minv: int, maxv: int) -> MinMax:
	var min_max = MinMax.new()
	min_max.min_value = minv
	min_max.max_value = maxv
	return min_max

@export var max_value: int = 10
@export var min_value: int = 0

func get_random_value() -> int:
	return randi_range(min_value, max_value)
