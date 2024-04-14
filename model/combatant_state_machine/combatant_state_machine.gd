extends StateMachine
class_name CombatantStateMachine

var _combatant: Combatant
var _battle: Battle

func _init(
	combatant: Combatant,
	battle: Battle
) -> void:
	_combatant = combatant
	_battle = battle

func initialize() -> void:
	super.initialize()
	var datastore = _compose_datastore(_combatant, _battle)
	for state in _get_states():
		state.datastore = datastore
	
func _compose_datastore(combatant: Combatant, battle: Battle) -> CombatantStateMachineDataStore:
	var datastore = CombatantStateMachineDataStore.new()
	datastore.battle = battle
	datastore.brain = combatant.brain
	datastore.combatant_id = combatant.id
	datastore.perception_component = combatant.perception
	return datastore

func _get_states() -> Array[CombatantState]:
	var states: Array[CombatantState] = []
	for child in get_children():
		if child is CombatantState:
			states.append(child)
	return states
