extends Node
class_name BattleController

var _battle: Battle
var _id_to_team: Dictionary
var _id_to_combatant: Dictionary

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
			
func _physics_process(_delta: float) -> void:
	var combatants: Array = _id_to_combatant.values()
	combatants.sort_custom(func(c0: CombatantController, c1: CombatantController):
		return c0.global_position.y < c1.global_position.y
	)
	for i in range(0, combatants.size()):
		var combatant: CombatantController = combatants[i]
		combatant.z_index = i
	
func add_team(team: Team) -> void:
	_id_to_team[team.id] = team
	add_child(team)
	
func add_combatant(team_id: String, combatant: CombatantController) -> void:
	_id_to_combatant[combatant.id] = combatant
	var team: Team = _id_to_team[team_id]
	combatant.team = team
	combatant.battle = _battle
	team.add_child(combatant)
	combatant.initialize()
	team.add_combatant(combatant.model)
