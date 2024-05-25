extends Brain
class_name StockBrain

func choose_oponent(oponents: Array) -> Combatant:
	return Array(oponents).pick_random()
	
func should_keep_fighting() -> bool:
	return true

func engage(_oponent: Combatant) -> EngageAction:
	return EngageAction.FIGHT
