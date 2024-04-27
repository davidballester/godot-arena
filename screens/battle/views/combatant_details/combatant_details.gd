extends Control
class_name PreparationCombatantDetails

signal closed()

@onready var _combatant_animated_sprite: AnimatedSprite2D = %CombatantAnimatedSprite
@onready var _combatant_name_label: Label = %CombatantNameLabel
@onready var _team_name_label: Label = %TeamNameLabel
@onready var _health_bar: HealthBar = %HealthBar
@onready var _health_label: Label = %HealthLabel
@onready var _weapon_animated_sprite: AnimatedSprite2D = %WeaponAnimatedSprite
@onready var _type_value: Label = %TypeValue
@onready var _weapon_value: Label = %WeaponValue
@onready var _close_buton: BaseButton = %CloseButton

var _combatant: Combatant

func _ready() -> void:
	_close_buton.pressed.connect(func():
		closed.emit()
	)

func show_details(combatant: Combatant, team: Team) -> void:
	_combatant = combatant
	_show_combatant_sprite()
	_health_bar.initialize(combatant.health, team.color)
	_show_weapon_animated_sprite()
	_show_labels(team)
	_health_label.text = "%s / %s" % [
		str(_combatant.health.current_value), 
		str(_combatant.health.max_value)
	]

func _input(event) -> void:
	if not visible or not event.is_action_pressed("escape"):
		return
	closed.emit()

func _show_combatant_sprite() -> void:
	_combatant_animated_sprite.sprite_frames = _combatant.sprite_frames
	_combatant_animated_sprite.play("idle")
	
func _show_weapon_animated_sprite() -> void:
	_weapon_animated_sprite.sprite_frames = _combatant.weapon.sprite_frames
	_weapon_animated_sprite.play("idle")
	
func _show_labels(team: Team) -> void:
	_combatant_name_label.text = _combatant.id
	_team_name_label.text = team.id
	_team_name_label.add_theme_color_override("font_color", team.color)
	_type_value.text = _combatant.type.capitalize()
	_type_value.add_theme_color_override("font_color", team.color)
	_weapon_value.text = _combatant.weapon.weapon_name.capitalize()
	_weapon_value.add_theme_color_override("font_color", team.color)
