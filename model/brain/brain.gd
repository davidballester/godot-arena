extends Node
class_name Brain

enum EngageAction {
	FIGHT,
	FLEE
}

var _combatant: Combatant

func initialize(combatant: Combatant):
	_combatant = combatant

# virtual
func choose_oponent(_oponents: Array) -> Combatant:
	return null
	
# virtual
func should_keep_fighting() -> bool:
	return false

# virtual
func engage(_oponent: Combatant) -> EngageAction:
	return EngageAction.FIGHT
