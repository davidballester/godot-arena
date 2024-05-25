extends CombatantState
class_name CombatantSeekEnemyState

static func get_state_name() -> String:
	return "CombatantSeekEnemyState"
	
func process(_delta: float) -> void:
	if state_machine.last_oponent and _should_fight_oponent(state_machine.last_oponent):
		state_machine.transition_to_state(
			CombatantApproachEnemyState.get_state_name(), 
			[state_machine.last_oponent]
		)
		return
	_choose_new_oponent()

func _choose_new_oponent() -> void:
	var oponents: Array = state_machine.battle.get_oponents(state_machine.combatant.id)
	if oponents.is_empty():
		state_machine.transition_to_state(CombatantVictoryState.get_state_name())
		return
	var chosen_oponent = state_machine.combatant.brain.choose_oponent(
		state_machine.combatant, 
		oponents
	)
	if chosen_oponent:
		state_machine.transition_to_state(
			CombatantApproachEnemyState.get_state_name(), 
			[chosen_oponent]
		)
	elif oponents.size():
		state_machine.transition_to_state(CombatantEscapeState.get_state_name())
	else:
		state_machine.transition_to_state(CombatantVictoryState.get_state_name())

func _should_fight_oponent(oponent: Combatant) -> bool:
	if not oponent or not oponent.is_alive() or not state_machine.combatant.can_attack(oponent.global_position):
		return false
	return state_machine.combatant.brain.should_keep_fighting(oponent)
