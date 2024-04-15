extends Control
class_name TeamScore

enum Position {
	TOP,
	BOTTOM
}

@onready var _team_name: Label = %TeamName
@onready var _health_bar: ProgressBar = %HealthBar
@onready var _image: Sprite2D = %Image

@export var custom_position: Position

var _team: Team

func initialize(team: Team, health_bar_color: Color) -> void:
	_team = team
	_team_name.text = team.id
	var fill_style_box: StyleBoxFlat = _health_bar.get_theme_stylebox("fill")
	var new_fill_style_box = fill_style_box.duplicate(true)
	new_fill_style_box.bg_color = health_bar_color
	_health_bar.add_theme_stylebox_override("fill", new_fill_style_box)
	if custom_position == Position.BOTTOM:
		_image.flip_v = true
		_team_name.position.y = 10
		_health_bar.position.y = 3
	
func _process(_delta: float) -> void:
	_health_bar.max_value = _get_team_max_health()
	_health_bar.value = _get_team_current_health()
	
func _get_team_max_health() -> int:
	return _team.combatants.reduce(
		func(acc: int, combatant: Combatant): return acc + combatant.health.max_value,
		0
	)
	
func _get_team_current_health() -> int:
	return _team.combatants.reduce(
		func(acc: int, combatant: Combatant): return acc + combatant.health.current_value,
		0
	)
