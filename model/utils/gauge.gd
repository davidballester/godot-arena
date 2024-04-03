extends Node
class_name Gauge

@export var max_value: float = 10.0
@export var min_value: float = 0.0
@export var current_value: float = 10.0:
	set(new_value):
		if new_value > max_value:
			current_value = max_value
		elif new_value < min_value:
			current_value = min_value
		else:
			current_value = new_value
			
func get_ratio() -> float :
	return (current_value - min_value) / (max_value - min_value)
