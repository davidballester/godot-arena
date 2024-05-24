extends Node
class_name Brain

enum EngageAction {
	FIGHT,
	FLEE
}

# virtual
func choose_oponent(_combatant: Combatant, _oponents: Array) -> Combatant:
	return null
	
# virtual
func should_keep_fighting(_combatant: Combatant) -> bool:
	return false

# virtual
func engage(_combatant: Combatant, _oponent: Combatant) -> EngageAction:
	return EngageAction.FIGHT
