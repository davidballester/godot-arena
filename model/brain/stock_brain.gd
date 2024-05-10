extends Brain
class_name StockBrain

func choose_oponent(
	_combatant: PerceivedCombatant, 
	oponents: Array[PerceivedCombatant]
) -> PerceivedCombatant:
	return Array(oponents).pick_random()
	
func should_keep_fighting(_combatant: PerceivedCombatant) -> bool:
	return true

func engage(_combatant: PerceivedCombatant, _oponent: PerceivedCombatant) -> EngageAction:
	return EngageAction.FIGHT
