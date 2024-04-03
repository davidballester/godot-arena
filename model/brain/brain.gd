extends Node
class_name Brain

enum EngageAction {
	FIGHT,
	FLEE
}

# virtual
func choose_oponent(
	_combatant: PerceivedCombatant,
	_oponents: Array[PerceivedCombatant]
) -> PerceivedCombatant:
	return null

# virtual
func engage(_combatant: PerceivedCombatant, _oponent: PerceivedCombatant) -> EngageAction:
	return EngageAction.FIGHT
