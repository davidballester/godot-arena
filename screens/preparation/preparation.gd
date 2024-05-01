extends CanvasLayer
class_name PreparationScreen

@onready var _team_panel: PreparationScreenTeamPanel = %TeamPanel
@onready var _combatant_details: PreparationScreenCombatantDetails = %CombatantDetails

func initialize(team: Team) -> void:
	_team_panel.combatant_selected.connect(func(combatant: Combatant):
		_combatant_details.initialize(combatant)
	)
	_team_panel.initialize(team)
