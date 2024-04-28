extends Control
class_name PreparationScreenTeamPanel

@onready var _team_name: PreparationScreenTeamName = %TeamName
@onready var _combatants_container: Control = %CombatantsContainer
@onready var _combatant_thumbnail_template: PreparationScreenCombatantThumbnail = %CombatantThumbnail

func _ready() -> void:
	_combatants_container.remove_child(_combatant_thumbnail_template)

func initialize(team: Team) -> void:
	_team_name.initialize(team)
	_team_name.team_changed.connect(func(team_name, team_icon):
		team.team_name = team_name
		team.icon = team_icon
	)
	team.combatants.map(_add_combatant_thumbnail)
	
func _add_combatant_thumbnail(combatant: Combatant) -> void:
	var combatant_thumbnail = _combatant_thumbnail_template.duplicate()
	combatant_thumbnail.ready.connect(func():
		combatant_thumbnail.initialize(combatant)
	)
	_combatants_container.add_child(combatant_thumbnail)
