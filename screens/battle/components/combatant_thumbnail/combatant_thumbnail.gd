extends Control
class_name BattleScreenCombatantThumbnail

@onready var _combatant_sprite_thumbnail: CombatantSpriteThumbnail = %CombatantSpriteThumbnail
@onready var _combatant_name: Label = %CombatantName
@onready var _health_bar: ProgressBar = %HealthBar

var _combatant: Combatant

func initialize(combatant: Combatant) -> void:
	_combatant = combatant
	_combatant_sprite_thumbnail.initialize(combatant, false)
	_combatant_name.text = combatant.id

func _process(_delta: float) -> void:
	if not _combatant:
		return
	_health_bar.max_value = _combatant.health.max_value
	_health_bar.min_value = _combatant.health.min_value
	_health_bar.value = _combatant.health.current_value
