extends Node
class_name TraitsData

const TRAITS_TABLE = "traits"

var _traits: Array

func _init(database: SQLite) -> void:
	var traits_results = database.select_rows(
		TRAITS_TABLE, 
		"", 
		[
			"key", 
			"incompatibilities",
			"name",
			"damage_taken_modifier",
			"damage_applied_modifier"
		]
	)
	_traits = traits_results.map(func(trait_result):
		var traitt = Trait.new()
		traitt.key = trait_result.key
		traitt.incompatibilities = Array(trait_result.incompatibilities.split(","))
		traitt.trait_name = trait_result.name
		traitt.damage_taken_modifier = trait_result.damage_taken_modifier if trait_result.damage_taken_modifier != null else 0
		traitt.damage_applied_modifier = trait_result.damage_applied_modifier if trait_result.damage_applied_modifier != null else 0
		return traitt
	)

func get_random_traits(traits_count: int) -> Array:
	var shuffled_traits = _traits.duplicate()
	shuffled_traits.shuffle()
	var traits = []
	while traits.size() < traits_count and shuffled_traits.size() > 0:
		var random_trait = shuffled_traits.pop_back()
		if _is_trait_compatible(traits, random_trait):
			traits.append(random_trait)
	return traits
	
func _is_trait_compatible(traits: Array, random_trait: Trait) -> bool:
	return traits.all(func(t): return not t.incompatibilities.has(random_trait.key))
