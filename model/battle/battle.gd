extends Node
class_name Battle

var teams: Array[Team]= []
var _id_to_combatant: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is Team:
			add_team(child)

func add_team(team: Team) -> void:
	teams.append(team)
	for combatant in team.combatants:
		_id_to_combatant[combatant.id] = combatant

func get_oponents(combatant_id: String) -> Array[Combatant]:
	var combatant = _id_to_combatant.get(combatant_id)
	if not combatant:
		return []
	var oponents = _id_to_combatant.values().filter(func(c: Combatant):
		return c.team_id != combatant.team_id
	)
	var ans: Array[Combatant] = []
	ans.assign(oponents)
	return ans

func is_combatant_alive(combatant_id: String) -> bool:
	return _id_to_combatant.has(combatant_id) and _id_to_combatant.get(combatant_id).is_alive()

func is_in_attack_range(combatant_id: String, oponent_id: String) -> bool:
	if not _id_to_combatant.has(combatant_id) or not _id_to_combatant.has(oponent_id):
		return false
	var combatant = _id_to_combatant.get(combatant_id)
	var oponent = _id_to_combatant.get(oponent_id)
	return combatant.can_attack(oponent.position)

func get_combatant(combatant_id: String) -> Combatant:
	return _id_to_combatant.get(combatant_id)
