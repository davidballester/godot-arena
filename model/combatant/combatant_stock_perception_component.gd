extends CombatantPerceptionComponent
class_name CombatantStockPerceptionComponent

func perceive_combatant(combatant: Combatant) -> PerceivedCombatant:
	var perceived_combatant = PerceivedCombatant.new()
	perceived_combatant.id = combatant.id
	perceived_combatant.distance = abs((self_combatant.position - combatant.position).length())
	if combatant.health.get_ratio() > 0.6:
		perceived_combatant.health = PerceivedStats.Health.HIGH
	elif combatant.health.get_ratio() > 0.3:
		perceived_combatant.health = PerceivedStats.Health.MEDIUM
	else:
		perceived_combatant.health = PerceivedStats.Health.LOW
	return perceived_combatant
