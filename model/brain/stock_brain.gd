extends Brain
class_name StockBrain

func choose_oponent(oponents: Array) -> Combatant:
	return Array(oponents).pick_random()
	
func react_to_being_engaged(oponents: Array) -> void:
	var new_oponent = choose_oponent(oponents)
	if new_oponent == _combatant.state_machine.last_oponent:
		return
	_combatant.state_machine.transition_to_state(
		CombatantEngageEnemyState.get_state_name(), 
		[new_oponent]
	)

func react_to_engagement(_engagig_oponent: Combatant, _engaged_by_oponents: Array) -> void:
	return
