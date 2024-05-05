extends Node
class_name BattlesData

const TERRAINS_PATH = "res://data/terrains"

var _terrains_paths: Array = []

func _init() -> void:
	var terrains_folder: DirAccess = DirAccess.open(TERRAINS_PATH)
	var all_files_in_folder = terrains_folder.get_files()
	for file_in_folder in all_files_in_folder:
		if not file_in_folder.ends_with(".tscn"):
			continue
		var terrain_full_path = "%s/%s" % [TERRAINS_PATH, file_in_folder]
		_terrains_paths.append(terrain_full_path)

func get_random_terrain_path() -> String:
	return _terrains_paths.pick_random()
	
