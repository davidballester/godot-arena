extends HBoxContainer
class_name TeamLabel

@onready var _team_icon: TextureRect = %TeamIcon
@onready var _team_name: Label = %TeamName

func show_team(team: Team) -> void:
	_team_icon.texture = team.icon
	_team_name.text = team.team_name
