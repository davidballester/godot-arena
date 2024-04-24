extends Node
class_name TeamsData

const TEAMS_ICONS_PATH = "res://assets/teams_icons"
const ADJECTIVES_TABLE_NAME = "teams_adjectives"
const NOUNS_TABLE_NAME = "teams_nouns"

var _database: SQLite
var _icons_used: Array = []
var _teams_icons_paths: Array = []
var _used_team_names: Array = []
var _used_teams_icons_paths: Array = []

func _init(database: SQLite) -> void:
	_database = database
	var teams_icons_folder: DirAccess = DirAccess.open(
		TEAMS_ICONS_PATH
	)
	var all_files_in_folder = teams_icons_folder.get_files()
	for file_in_folder in all_files_in_folder:
		if not file_in_folder.ends_with(".png") or _icons_used.has(file_in_folder):
			continue
		var team_icon_full_path = "%s/%s" % [TEAMS_ICONS_PATH, file_in_folder]
		_teams_icons_paths.append(team_icon_full_path)

func get_random_icon_path() -> String:
	var random_index = randi_range(0, _teams_icons_paths.size() - 1)
	var random_team_icon = _teams_icons_paths[random_index]
	if _used_teams_icons_paths.has(random_team_icon):
		return get_random_icon_path()
	return random_team_icon
	
func mark_team_icon_path_as_used(team_icon_path: String) -> void:
	_used_teams_icons_paths.append(team_icon_path)

func get_random_team_name() -> String:
	var random_adjective = _get_random_query_result(ADJECTIVES_TABLE_NAME, "adjective")
	var random_noun = _get_random_query_result(NOUNS_TABLE_NAME, "noun")
	var random_team_name = "%s %s" % [random_adjective, random_noun]
	if _used_team_names.has(random_team_name):
		return get_random_team_name()
	return random_team_name
	
func mark_team_name_as_used(team_name: String) -> void:
	_used_team_names.append(team_name)
	
func _get_random_query_result(table_name: String, column: String) -> String:
	var rows = _database.select_rows(table_name, "", [column])
	var random_row = rows.pick_random()
	return random_row[column]
