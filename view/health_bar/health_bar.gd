extends ProgressBar
class_name HealthBar

var _health: Gauge

func initialize(health: Gauge, color: Color) -> void:
	_health = health
	max_value = _health.max_value
	min_value = _health.min_value
	value = _health.current_value
	var fill_style_box: StyleBoxFlat = get_theme_stylebox("fill")
	var new_fill_style_box = fill_style_box.duplicate(true)
	new_fill_style_box.bg_color = color
	add_theme_stylebox_override("fill", new_fill_style_box)
	
func _physics_process(_delta: float) -> void:
	if not _health:
		return
	value = _health.current_value
