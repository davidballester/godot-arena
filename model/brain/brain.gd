extends Node
class_name Brain

var _combatant: Combatant

func initialize(combatant: Combatant):
	_combatant = combatant

# virtual
func choose_oponent(_oponents: Array) -> Combatant:
	return null
	
# virtual
func react_to_being_engaged(_oponents: Array) -> void:
	return
	
# virtual
func react_to_engagement(_engagig_oponent: Combatant, _engaged_by_oponents: Array) -> void:
	return
