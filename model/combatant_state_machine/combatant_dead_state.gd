extends CombatantState
class_name CombatantDeadState

static func get_state_name() -> String:
	return "CombatantDeadState"
	
func process(_delta: float) -> void:
	if not state_machine.combatant.is_alive():
		return
	state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
