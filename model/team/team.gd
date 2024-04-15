extends Node
class_name Team

@export var id: String
var team_name: String
var combatants: Array[Combatant]= []
var color: Color
var icon: Texture2D

func _ready() -> void:
	for child in get_children():
		if child is Combatant:
			var combatant: Combatant = child
			add_combatant(combatant)
			
func add_combatant(combatant: Combatant) -> void:
	combatant.team_id = id
	combatants.append(combatant)
