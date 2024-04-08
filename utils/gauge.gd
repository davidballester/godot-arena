extends MinMax
class_name Gauge

@export var current_value: int = 10:
	set(new_value):
		if new_value > max_value:
			current_value = max_value
		elif new_value < min_value:
			current_value = min_value
		else:
			current_value = new_value
			
func get_ratio() -> float :
	@warning_ignore("integer_division")
	return (current_value - min_value) / (max_value - min_value)

func get_random_value() -> int:
	return randi_range(min_value, current_value)

func _to_string() -> String:
	return "Gauge(min={min}, max={max}, current={current})".format({
		"min": str(min_value),
		"max": str(max_value),
		"current": str(current_value)
	})
