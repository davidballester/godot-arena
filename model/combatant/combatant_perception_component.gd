extends Node
class_name CombatantPerceptionComponent

var self_combatant: Combatant

# virtual
func perceive_combatant(_combatant: Combatant) -> PerceivedCombatant:
	return null
