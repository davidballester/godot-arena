extends Brain
class_name StockBrain

func choose_oponent(
	combatant: PerceivedCombatant, 
	oponents: Array[PerceivedCombatant]
) -> PerceivedCombatant:
	if combatant.health == PerceivedStats.Health.LOW:
		return null
	var oponents_sorted_by_distance = Array(oponents)
	oponents_sorted_by_distance.sort_custom(func(a: PerceivedCombatant, b:PerceivedCombatant):
		return b.distance < a.distance
	)
	return oponents_sorted_by_distance.pop_back()

func engage(combatant: PerceivedCombatant, oponent: PerceivedCombatant) -> EngageAction:
	if combatant.health == PerceivedStats.Health.LOW:
		return EngageAction.FIGHT if oponent.health == PerceivedStats.Health.LOW else EngageAction.FLEE
	return EngageAction.FIGHT
