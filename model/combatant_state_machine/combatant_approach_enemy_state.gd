extends CombatantState
class_name CombatantApproachEnemyState

const SEEK_ENEMY_AFTER_MS = 2e3

static func get_state_name() -> String:
	return "CombatantApproachEnemyState"

var combatant_id: String

var _active_ms: float = 0.0

func enter(args: Array) -> void:
	combatant_id = args[0]
	_active_ms = 0
	
func exit() -> void:
	combatant_id = ""

func process(delta: float) -> void:
	_active_ms += delta
	if not combatant_id or not datastore.battle.is_combatant_alive(combatant_id) or _active_ms >= SEEK_ENEMY_AFTER_MS:
		state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
	if datastore.battle.is_in_attack_range(datastore.combatant_id, combatant_id):
		state_machine.transition_to_state(
			CombatantEngageEnemyState.get_state_name(), 
			[combatant_id]
		)
