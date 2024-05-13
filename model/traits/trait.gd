extends Node
class_name Trait

var key: String
var incompatibilities: Array
var trait_name: String
var description: String
var damage_applied_modifier: int
var damage_taken_modifier: int

func _to_string() -> String:
	return "Trait(key={key}, damage_applied_modifier={damage_applied_modifier}, damage_taken_modifier={damage_taken_modifier})".format({
		"key": key,
		"damage_applied_modifier": str(damage_applied_modifier),
		"damage_taken_modifier": str(damage_taken_modifier)
	})
