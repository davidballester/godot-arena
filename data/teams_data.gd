extends Node
class_name TeamsData

const TEAMS_ICONS_PATH = "res://assets/teams_icons"

var _icons_used: Array = []
var _teams_icons_paths: Array = []

func _init() -> void:
	var teams_icons_folder: DirAccess = DirAccess.open(
		TEAMS_ICONS_PATH
	)
	var all_files_in_folder = teams_icons_folder.get_files()
	for file_in_folder in all_files_in_folder:
		if not file_in_folder.ends_with(".png") or _icons_used.has(file_in_folder):
			continue
		var team_icon_full_path = "%s/%s" % [TEAMS_ICONS_PATH, file_in_folder]
		_teams_icons_paths.append(team_icon_full_path)

func get_random_icon() -> Texture2D:
	var random_index = randi_range(0, _teams_icons_paths.size() - 1)
	var random_team_icon = _teams_icons_paths.pop_at(random_index)
	return load(random_team_icon)
