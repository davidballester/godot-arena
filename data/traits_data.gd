extends Node
class_name TraitsData

const BASE_TRAITS_PATH = "res://model/traits/instances"

var _traits_paths: Array = []

func _init() -> void:
	var trais_folder: DirAccess = DirAccess.open(BASE_TRAITS_PATH)
	var all_files_in_folder = trais_folder.get_files()
	for file_in_folder in all_files_in_folder:
		if not file_in_folder.ends_with(".gd"):
			continue
		var trait_full_path = "%s/%s" % [BASE_TRAITS_PATH, file_in_folder]
		_traits_paths.append(trait_full_path)
		
func get_random_trait() -> Trait:
	var random_trait_path = _traits_paths.pick_random()
	return load(random_trait_path).new()
