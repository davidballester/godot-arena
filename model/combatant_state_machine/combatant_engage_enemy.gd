extends CombatantState
class_name CombatantEngageEnemyState

static func get_state_name() -> String:
	return "CombatantEngageEnemyState"
	
func enter(args: Array) -> void:
	var oponent: Combatant = args[0]
	state_machine.last_oponent = oponent
	
func exit() -> void:
	state_machine.last_oponent = null

func process(_delta: float) -> void:
	if not state_machine.last_oponent.is_alive():
		state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
		return
	if not state_machine.combatant.can_attack(state_machine.last_oponent.global_position):
		state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
		return
	var action = state_machine.combatant.brain.engage(
		state_machine.combatant, 
		state_machine.last_oponent
	)
	if action == Brain.EngageAction.FLEE:
		state_machine.transition_to_state(CombatantEscapeState.get_state_name())
	
