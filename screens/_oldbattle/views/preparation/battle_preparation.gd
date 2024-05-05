extends CanvasLayer
class_name BattlePreparation

@onready var _player_team_view: TeamView = %PlayerTeam

func initialize(
	player_team: Team
) -> void:
	_player_team_view.initialize(player_team)
