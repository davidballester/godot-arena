extends Control
class_name CombatantDetails

@onready var _combatant_animated_sprite: AnimatedSprite2D = %CombatantAnimatedSprite
@onready var _combatant_name_label: Label = %CombatantNameLabel
@onready var _team_name_label: Label = %TeamNameLabel
@onready var _health_bar: HealthBar = %HealthBar
@onready var _health_label: Label = %HealthLabel
@onready var _weapon_animated_sprite = %WeaponAnimatedSprite
@onready var _type_value = %TypeValue
@onready var _weapon_value = %WeaponValue

var _combatant: Combatant

func show_details(combatant: Combatant, team: Team) -> void:
	if _combatant:
		_combatant.state_machine.state_changed.disconnect(_on_combatant_state_changed)
	_combatant = combatant
	_show_combatant_sprite()
	_health_bar.initialize(combatant.health, team.color)
	_show_weapon_animated_sprite()
	_show_labels(team)

func _on_combatant_state_changed(state: State) -> void:
	if state is CombatantDeadState:
		_die()
		return
	if state is CombatantHitState:
		_hit()
		return

func _input(event) -> void:
	if not visible:
		return
	if event.is_action_pressed("escape"):
		hide()
		
func _process(_delta: float) -> void:
	if not visible or not _combatant:
		return
	_health_label.text = "%s / %s" % [
		str(_combatant.health.current_value), 
		str(_combatant.health.max_value)
	]

func _die() -> void:
	_combatant_animated_sprite.play("death")
	var tween = get_tree().create_tween()
	tween.tween_property(_weapon_animated_sprite, "modulate:a", 0, 1.0)
		
func _hit() -> void:
	_combatant_animated_sprite.play("hit")
	await _combatant_animated_sprite.animation_finished
	_combatant_animated_sprite.play("idle")

func _show_combatant_sprite() -> void:
	_combatant_animated_sprite.sprite_frames = _combatant.sprite_frames
	if not _combatant.is_alive():
		_combatant_animated_sprite.speed_scale = 0
		_combatant_animated_sprite.play("death", -1.0, true)
	else:
		_combatant_animated_sprite.play("idle")
		_combatant.state_machine.state_changed.connect(_on_combatant_state_changed)
	
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
