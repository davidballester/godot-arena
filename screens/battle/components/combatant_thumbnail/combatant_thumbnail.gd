extends Control
class_name BattleScreenCombatantThumbnail

signal selected()

@onready var _combatant_sprite_thumbnail: CombatantSpriteThumbnail = %CombatantSpriteThumbnail
@onready var _combatant_name: Label = %CombatantName
@onready var _health_bar: ProgressBar = %HealthBar
@onready var _button: BaseButton = %Button

var _combatant: Combatant

func initialize(combatant: Combatant) -> void:
	_combatant = combatant
	_combatant_sprite_thumbnail.initialize(combatant, false)
	_combatant.state_machine.state_changed.connect(_update_animation_based_on_state)
	_combatant_name.text = combatant.id
	_button.pressed.connect(func(): selected.emit())

func _process(_delta: float) -> void:
	if not _combatant:
		return
	_health_bar.max_value = _combatant.health.max_value
	_health_bar.min_value = _combatant.health.min_value
	_health_bar.value = _combatant.health.current_value

func _update_animation_based_on_state(state: CombatantState) -> void:
	if state is CombatantDeadState:
		_combatant_sprite_thumbnail.play("death")
		return
	if state is CombatantHitState:
		_combatant_sprite_thumbnail.play("hit")
		return
	_combatant_sprite_thumbnail.play_first_frame("idle")
