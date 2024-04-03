extends CombatantState
class_name CombatantApproachEnemyState

static func get_state_name() -> String:
	return "CombatantApproachEnemyState"

var combatant_id: String

func enter(args: Array) -> void:
	combatant_id = args[0]
	
func exit() -> void:
	combatant_id = ""

func process(_delta: float) -> void:
	if not combatant_id or not datastore.battle.is_combatant_alive(combatant_id):
		state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
	if datastore.battle.is_in_attack_range(datastore.combatant_id, combatant_id):
		state_machine.transition_to_state(CombatantEngageEnemyState.get_state_name(), [combatant_id])
