extends CombatantState
class_name CombatantEngageEnemyState

static func get_state_name() -> String:
	return "CombatantEngageEnemyState"
	
var combatant: Combatant
var oponent: Combatant
	
func enter(args: Array) -> void:
	var oponent_id: String = args[0]
	datastore.last_oponent_id = oponent_id
	oponent = datastore.battle.get_combatant(oponent_id)
	combatant = datastore.battle.get_combatant(datastore.combatant_id)
	
func exit() -> void:
	oponent = null

func process(_delta: float) -> void:
	if not oponent.is_alive():
		state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
		return
	if not combatant.can_attack(oponent.global_position):
		state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
		return
	var action = datastore.brain.engage(combatant, oponent)
	if action == Brain.EngageAction.FLEE:
		state_machine.transition_to_state(CombatantEscapeState.get_state_name())
	
