extends Control
class_name BattleScreenTeamScore

enum Position {
	TOP,
	BOTTOM
}

signal team_clicked()

@export var custom_position: Position

@onready var _team_name: Label = %TeamName
@onready var _health_bar: ProgressBar = %HealthBar
@onready var _layout: Sprite2D = %Layout
@onready var _team_icon: Sprite2D = %TeamIcon
@onready var _button: BaseButton = %Button

var _team: Team

func initialize(team: Team) -> void:
	_team = team
	_team_name.text = team.team_name
	_team_icon.texture = team.icon
	var fill_style_box: StyleBoxFlat = _health_bar.get_theme_stylebox("fill")
	var new_fill_style_box = fill_style_box.duplicate(true)
	new_fill_style_box.bg_color = team.color
	_health_bar.add_theme_stylebox_override("fill", new_fill_style_box)
	if custom_position == Position.BOTTOM:
		_layout.flip_v = true
		_team_name.position.y = 10
		_health_bar.position.y = 3
	_button.pressed.connect(func(): team_clicked.emit())
	
func _process(_delta: float) -> void:
	if not _team:
		return
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
