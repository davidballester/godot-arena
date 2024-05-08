extends CombatantState
class_name CombatantDeadState

static func get_state_name() -> String:
	return "CombatantDeadState"

var _combatant: Combatant

func enter(_args: Array) -> void:
	_combatant = datastore.battle.get_combatant(datastore.combatant_id)
	
func process(_delta: float) -> void:
	if not _combatant.is_alive():
		return
	state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
