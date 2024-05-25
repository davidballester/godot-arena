extends CombatantState
class_name CombatantApproachEnemyState

const SEEK_ENEMY_AFTER_MS = 2e3

static func get_state_name() -> String:
	return "CombatantApproachEnemyState"

var _active_ms: float = 0.0

func enter(args: Array) -> void:
	state_machine.last_oponent = args[0]
	_active_ms = 0
	
func exit() -> void:
	state_machine.last_oponent = null

func process(delta: float) -> void:
	_active_ms += delta
	if not state_machine.last_oponent or not state_machine.last_oponent.is_alive() or _active_ms >= SEEK_ENEMY_AFTER_MS:
		state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
		return
	if state_machine.combatant.can_attack(state_machine.last_oponent.global_position):
		state_machine.transition_to_state(
			CombatantEngageEnemyState.get_state_name(), 
			[state_machine.last_oponent]
		)
