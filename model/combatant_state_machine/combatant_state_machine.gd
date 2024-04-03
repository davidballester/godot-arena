extends StateMachine
class_name CombatantStateMachine

func initialize(
	combatant: Combatant,
	battle: Battle
) -> void:
	var datastore = _compose_datastore(combatant, battle)
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
