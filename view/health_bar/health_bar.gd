extends ProgressBar
class_name HealthBar

var _health: Gauge

func initialize(health: Gauge) -> void:
	_health = health
	max_value = _health.max_value
	min_value = _health.min_value
	value = _health.current_value
	fade_out()
	
func fade_in() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, 0.3)
	await tween.finished
	
func fade_out() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.5, 0.3)
	await tween.finished
	
func _physics_process(_delta: float) -> void:
	value = _health.current_value

