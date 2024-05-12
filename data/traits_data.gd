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

func get_random_traits(count: int) -> Array:
	var random_traits_paths = _traits_paths.duplicate()
	random_traits_paths.shuffle()
	var traits = []
	while traits.size() < count and random_traits_paths.size() > 0:
		var random_trait_path = random_traits_paths.pop_back()
		var random_trait = load(random_trait_path).new()
		if not _is_incompatible(random_trait, traits):
			traits.append(random_trait)
	return traits
	
func _is_incompatible(traitt: Trait, traits: Array) -> bool:
	return traits.reduce(
		func (is_incompatible: bool, t: Trait) -> bool:
			return is_incompatible or t.get_incompatibilities().has(traitt.get_trait_name()),
		false
	)
