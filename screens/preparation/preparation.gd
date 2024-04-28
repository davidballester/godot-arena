extends CanvasLayer
class_name PreparationScreen

@onready var _team_panel: PreparationScreenTeamPanel = %TeamPanel

func initialize(team: Team) -> void:
	_team_panel.initialize(team)
