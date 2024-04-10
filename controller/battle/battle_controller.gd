extends Node
class_name BattleController

var _battle: Battle
var _id_to_team: Dictionary

func _ready() -> void:
	_battle = Battle.new()
	for child in get_children():
		if not child is Team:
			continue
		var team: Team = child
		_id_to_team[team.id] = team
		for team_child in team.get_children():
			if not team_child is CombatantController:
				continue
			var combatant: CombatantController = team_child
			team.remove_child(combatant)
			add_combatant(team.id, combatant)
			
	
func add_team(team: Team) -> void:
	_id_to_team[team.id] = team
	add_child(team)
	
func add_combatant(team_id: String, combatant: CombatantController) -> void:
	var team: Team = _id_to_team[team_id]
	combatant.team = team
	combatant.battle = _battle
	team.add_child(combatant)
	combatant.initialize()
	team.add_combatant(combatant.model)
