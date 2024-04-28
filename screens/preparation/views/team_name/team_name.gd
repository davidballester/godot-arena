extends Control
class_name PreparationScreenTeamName

signal team_changed(String, Texture2D)

@onready var _team_icon: TextureRect = %TeamIcon
@onready var _team_name: Label = %TeamName
@onready var _change_button: StyledButton = %ChangeButton

func initialize(team: Team):
	_team_icon.texture = team.icon
	_team_name.text = team.team_name
	_change_button.pressed.connect(_change_team)

func _change_team() -> void:
	var team_name = GameGlobals.get_teams_data().get_random_team_name()
	var team_icon_path = GameGlobals.get_teams_data().get_random_icon_path()
	var team_icon = load(team_icon_path)
	_team_icon.texture = team_icon
	_team_name.text = team_name
	team_changed.emit(team_name, team_icon)
