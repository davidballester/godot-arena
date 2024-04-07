extends CombatantState
class_name CombatantHitState

const HIT_DURATION_S: float = 0.4

var damage

static func get_state_name() -> String:
	return "CombatantHitState"

func enter(args: Array) -> void:
	damage = args[0]
	var combatant = datastore.battle.get_combatant(datastore.combatant_id)
	combatant.health.current_value -= damage
	await get_tree().create_timer(HIT_DURATION_S).timeout
	if not combatant.is_alive():
		state_machine.transition_to_state(CombatantDeadState.get_state_name())
	else:
		state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
