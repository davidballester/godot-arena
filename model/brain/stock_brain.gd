extends Brain
class_name StockBrain

func choose_oponent(_combatant: Combatant, oponents: Array) -> Combatant:
	return Array(oponents).pick_random()
	
func should_keep_fighting(_combatant: Combatant) -> bool:
	return true

func engage(_combatant: Combatant, _oponent: Combatant) -> EngageAction:
	return EngageAction.FIGHT
