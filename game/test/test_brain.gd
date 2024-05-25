extends Brain
class_name TestBrain

func choose_oponent(_oponents: Array) -> Combatant:
	return null
	
func should_keep_fighting() -> bool:
	return false

func engage(_oponent: Combatant) -> EngageAction:
	return EngageAction.FIGHT
