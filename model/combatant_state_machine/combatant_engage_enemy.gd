extends CombatantState
class_name CombatantEngageEnemyState

static func get_state_name() -> String:
	return "CombatantEngageEnemyState"
	
func enter(args: Array) -> void:
	var oponent: Combatant = args[0]
	state_machine.last_oponent = oponent
	oponent.state_machine.engaged_by(state_machine.combatant)
	
func exit() -> void:
	state_machine.last_oponent.state_machine.no_longer_engaged_by(state_machine.combatant)
	state_machine.last_oponent = null

func process(_delta: float) -> void:
	if not state_machine.last_oponent.is_alive():
		state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
		return
	if not state_machine.combatant.can_attack(state_machine.last_oponent.global_position):
		state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
		return
	state_machine.combatant.brain.react_to_engagement(
		state_machine.last_oponent,
		state_machine.get_engaged_by()
	)
	
