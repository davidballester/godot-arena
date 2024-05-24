extends Brain
class_name TestBrain

func choose_oponent(_combatant: Combatant, _oponents: Array) -> Combatant:
	return null
	
func should_keep_fighting(_combatant: Combatant) -> bool:
	return false

func engage(_combatant: Combatant, _oponent: Combatant) -> EngageAction:
	return EngageAction.FIGHT
