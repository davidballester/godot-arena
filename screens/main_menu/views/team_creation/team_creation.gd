extends Control
class_name MainMenuTeamCreationView

signal team_created(Team)
signal close_clicked()

@onready var _another_team_button: BaseButton = %AnotherTeamButton
@onready var _select_team_button: BaseButton = %SelectTeamButton
@onready var _team_label: TeamLabel = %TeamLabel
@onready var _close_button: BaseButton = %CloseButton

var _team: Team
var _team_icon_path: String

func _ready() -> void:
	_get_random_team()
	_another_team_button.pressed.connect(_get_random_team)
	_select_team_button.pressed.connect(_select_team)
	_close_button.pressed.connect(func():
		close_clicked.emit()
	)
	
func _get_random_team() -> void:
	_team_icon_path = GameGlobals.get_teams_data().get_random_icon_path()
	var team_icon = load(_team_icon_path)
	var team_name = GameGlobals.get_teams_data().get_random_team_name()
	_team = Team.new(
		team_name,
		team_name,
		Color.from_string("#f77622", Color.DARK_RED),
		team_icon
	)
	_team_label.show_team(_team)

func _select_team() -> void:
	GameGlobals.get_teams_data().mark_team_icon_path_as_used(_team_icon_path)
	GameGlobals.get_teams_data().mark_team_name_as_used(_team.team_name)
	team_created.emit(_team)
