extends Node
class_name Team

@export var id: String
var team_name: String
var combatants: Array[Combatant]
var color: Color
var icon: Texture2D

func _init(
	id: String,
	team_name: String,
	color: Color,
	icon: Texture2D
):
	self.id = id
	self.team_name = team_name
	self.color = color
	self.icon = icon
	self.combatants = []

func add_combatant(combatant: Combatant) -> void:
	combatant.team_id = id
	combatants.append(combatant)
