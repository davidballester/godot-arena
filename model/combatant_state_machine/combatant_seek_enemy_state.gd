extends CombatantState
class_name CombatantSeekEnemyState

static func get_state_name() -> String:
	return "CombatantSeekEnemyState"

func process(_delta: float) -> void:
	var oponents = datastore.battle.get_oponents(datastore.combatant_id)
	var perceived_oponents = oponents.map(func(o: Combatant):
		return datastore.perception_component.perceive_combatant(o)
	)
	var perceived_oponents_typed: Array[PerceivedCombatant] = []
	perceived_oponents_typed.assign(perceived_oponents)
	var combatant = datastore.battle.get_combatant(datastore.combatant_id)
	var perceived_combatant = datastore.perception_component.perceive_combatant(combatant)
	var chosen_oponent = datastore.brain.choose_oponent(
		perceived_combatant, 
		perceived_oponents_typed
	)
	if chosen_oponent:
		state_machine.transition_to_state(
			CombatantApproachEnemyState.get_state_name(), 
			[chosen_oponent.id]
		)
	elif oponents.size():
		state_machine.transition_to_state(CombatantEscapeState.get_state_name())
	else:
		state_machine.transition_to_state(CombatantVictoryState.get_state_name())
