extends Brain
class_name TestBrain

func choose_oponent(
	_combatant: PerceivedCombatant, 
	_oponents: Array[PerceivedCombatant]
) -> PerceivedCombatant:
	return null
	
func should_keep_fighting(_combatant: PerceivedCombatant) -> bool:
	return false

func engage(_combatant: PerceivedCombatant, _oponent: PerceivedCombatant) -> EngageAction:
	return EngageAction.FIGHT
