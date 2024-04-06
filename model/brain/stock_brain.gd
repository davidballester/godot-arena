extends Brain
class_name StockBrain

func choose_oponent(
	_combatant: PerceivedCombatant, 
	oponents: Array[PerceivedCombatant]
) -> PerceivedCombatant:
	var oponents_sorted_by_distance = Array(oponents)
	oponents_sorted_by_distance.sort_custom(func(a: PerceivedCombatant, b:PerceivedCombatant):
		return b.distance < a.distance
	)
	return oponents_sorted_by_distance.pop_back()

func engage(_combatant: PerceivedCombatant, _oponent: PerceivedCombatant) -> EngageAction:
	return EngageAction.FIGHT
