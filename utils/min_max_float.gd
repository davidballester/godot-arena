extends Node
class_name MinMaxFloat

static func create(minv: float, maxv: float) -> MinMaxFloat:
	var min_max = MinMaxFloat.new()
	min_max.min_value = minv
	min_max.max_value = maxv
	return min_max

@export var max_value: float = 10.0
@export var min_value: float = 0.0

func get_random_value() -> float:
	return randf_range(min_value, max_value)
