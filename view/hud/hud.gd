extends CanvasLayer
class_name HUD

@onready var _first_team_score: TeamScore = %FirstTeamScore
@onready var _second_team_score: TeamScore = %SecondTeamScore

func initialize(first_team: Team, second_team: Team) -> void:
	_first_team_score.initialize(first_team)
	_second_team_score.initialize(second_team)
