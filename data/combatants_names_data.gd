extends Node
class_name CombatantsNamesData

const COMBATANTS_NAMES_TABLE = "combatants_names"
const COMBATANTS_NAMES_TEMPLATES_TABLE = "combatants_names_templates"
const TEMPLATE_USAGE_CHANCE = 0.8

var _type_to_names: Dictionary
var _names_templates: Array

func _init(database: SQLite) -> void:
	var name_query_results = database.select_rows(
		COMBATANTS_NAMES_TABLE, 
		"", 
		["type", "name"]
	)
	_type_to_names = name_query_results.reduce(
		func(acc, name_query_result):
			var type = name_query_result.type
			if not acc.get(type):
				acc[type] = []
			acc[type].append(name_query_result.name)
			return acc,
		{}
	)
	var names_templates_results = database.select_rows(
		COMBATANTS_NAMES_TEMPLATES_TABLE,
		"",
		["template"]
	)
	_names_templates = names_templates_results.map(
		func(names_templates_result): return names_templates_result.template
	)

func get_random_name(type: String) -> String:
	var names: Array = _type_to_names[type]
	var random_name = names.pick_random()
	var use_template = randf() < TEMPLATE_USAGE_CHANCE
	if not use_template:
		return random_name
	var random_template: String = _names_templates.pick_random()
	return random_template.replace("{{NAME}}", random_name)
