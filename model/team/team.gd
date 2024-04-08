extends Node
class_name Team

@export var id: String = "team1234"
var team_name: String = "Adventurers"
var combatants: Array[Combatant]= []

func _ready() -> void:
	for child in get_children():
		if child is Combatant:
			var combatant: Combatant = child
			add_combatant(combatant)
			
func add_combatant(combatant: Combatant) -> void:
	combatant.team_id = id
	combatants.append(combatant)
