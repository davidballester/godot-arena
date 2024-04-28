extends Control
class_name PreparationScreenTeamPanel

signal combatant_selected(Combatant)

@onready var _team_name: PreparationScreenTeamName = %TeamName
@onready var _combatants_container: Control = %CombatantsContainer
@onready var _combatant_thumbnail_template: PreparationScreenCombatantThumbnail = %CombatantThumbnail
var _selected_combatant: PreparationScreenCombatantThumbnail

func _ready() -> void:
	_combatants_container.remove_child(_combatant_thumbnail_template)

func initialize(team: Team) -> void:
	_team_name.initialize(team)
	_team_name.team_changed.connect(func(team_name, team_icon):
		team.team_name = team_name
		team.icon = team_icon
	)
	team.combatants.map(_add_combatant_thumbnail)
	_select_combatant_thumbnail(
		team.combatants[0], 
		_combatants_container.get_children()[0]
	)
	
func _add_combatant_thumbnail(combatant: Combatant) -> void:
	var combatant_thumbnail: PreparationScreenCombatantThumbnail = _combatant_thumbnail_template.duplicate()
	combatant_thumbnail.ready.connect(func():
		combatant_thumbnail.initialize(combatant)
	)
	_combatants_container.add_child(combatant_thumbnail)
	combatant_thumbnail.pressed.connect(func(): 
		_select_combatant_thumbnail(combatant, combatant_thumbnail)
	)

func _select_combatant_thumbnail(
	combatant: Combatant,
	combatant_thumbnail: PreparationScreenCombatantThumbnail
) -> void:	
	if _selected_combatant:
		_selected_combatant.set_selected(false)
	combatant_selected.emit(combatant)
	combatant_thumbnail.set_selected(true)
	_selected_combatant = combatant_thumbnail
