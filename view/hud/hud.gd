extends CanvasLayer
class_name HUD

@onready var _first_team_score: TeamScore = %FirstTeamScore
@onready var _second_team_score: TeamScore = %SecondTeamScore
@onready var _combatant_details: CombatantDetails = %CombatantDetails

func initialize(first_team: Team, second_team: Team) -> void:
	_first_team_score.initialize(first_team, first_team.color)
	_second_team_score.initialize(second_team, second_team.color)

func show_combatant_details(combatant: Combatant, team: Team) -> void:
	_combatant_details.show_details(combatant, team)

func hide_combatant_details() -> void:
	_combatant_details.hide_details()
