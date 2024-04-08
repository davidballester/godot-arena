extends ProgressBar
class_name HealthBar

var _health: Gauge

func initialize(health: Gauge) -> void:
	_health = health
	max_value = _health.max_value
	min_value = _health.min_value
	value = _health.current_value
	
func _physics_process(_delta: float) -> void:
	value = _health.current_value

