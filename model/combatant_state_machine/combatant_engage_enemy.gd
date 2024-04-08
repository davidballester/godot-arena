extends CombatantState
class_name CombatantEngageEnemyState

static func get_state_name() -> String:
	return "CombatantEngageEnemyState"
	
var combatant: Combatant
	
func enter(args: Array) -> void:
	var combatant_id: String = args[0]
	combatant = datastore.battle.get_combatant(combatant_id)
	
func exit() -> void:
	combatant = null

func process(_delta: float) -> void:
	if not combatant.is_alive():
		state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
		return
	var self_combatant = datastore.battle.get_combatant(datastore.combatant_id)
	if not self_combatant.can_attack(combatant.global_position):
		state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
		return
	var perceived_combatant = datastore.perception_component.perceive_combatant(combatant)
	var self_perceived_combatant = datastore.perception_component.perceive_combatant(self_combatant)
	var action = datastore.brain.engage(self_perceived_combatant, perceived_combatant)
	if action == Brain.EngageAction.FLEE:
		state_machine.transition_to_state(CombatantEscapeState.get_state_name())
	
